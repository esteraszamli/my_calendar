import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/pages/add_note/add_note_page.dart';
import 'package:my_calendar/pages/calendar/cubit/calendar_cubit.dart';
import 'package:my_calendar/pages/login/profile_page.dart';
import 'package:my_calendar/pages/note/note_page.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var currentIndex = 0;
  int _dateTapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 99, 222, 231),
        title: Text(
          'Mój Kalendarz',
          style: GoogleFonts.outfit(fontSize: 23, fontWeight: FontWeight.w400),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Kalendarz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 39, 206, 225),
      ),
      body: BlocProvider<CalendarCubit>(
        create: (context) => getIt<CalendarCubit>()..start(DateTime.now()),
        child: BlocConsumer<CalendarCubit, CalendarState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Błąd zapisu: ${state.errorMessage}')),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (currentIndex == 1) {
              return const ProfilePage();
            }
            return _buildCalendarContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildCalendarContent(BuildContext context, CalendarState state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TableCalendar(
            locale: 'pl',
            firstDay: DateTime(2023),
            lastDay: DateTime(2030),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: GoogleFonts.outfit(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              weekendStyle: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 121, 121, 121),
                fontSize: 14,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 99, 222, 231).withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 99, 222, 231).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              holidayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 49, 174, 191).withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
            holidayPredicate: (day) => _isHoliday(day, state),
            onDaySelected: (selectedDay, focusedDay) {
              _handleDaySelection(context, selectedDay, focusedDay);
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
                // Wywołanie start() dla nowego roku/miesiąca
                context.read<CalendarCubit>().start(focusedDay);
              });
            },
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
        ),
        if (_selectedDay != null)
          SliverToBoxAdapter(
            child: _buildHolidayInfo(state),
          ),
        _buildNotesListSliver(state),
      ],
    );
  }

  void _handleDaySelection(
      BuildContext context, DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _dateTapCount = 1;
        context.read<CalendarCubit>().start(selectedDay);
      });
    } else {
      setState(() {
        _dateTapCount++;
      });
      if (_dateTapCount % 2 == 0) {
        _showAddNoteDialog(context, selectedDay);
      }
    }
  }

  void _showAddNoteDialog(BuildContext context, DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: const Text(
            'Stwórz notatkę',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Czy chcesz utworzyć nową notatkę?',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Anuluj',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotePage(
                        selectedDate: DateTime(
                      selectedDay.year,
                      selectedDay.month,
                      selectedDay.day,
                    )),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildHolidayInfo(CalendarState state) {
    if (_selectedDay != null) {
      final holidayName = _getHolidayName(_selectedDay!, state);
      if (holidayName != null) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Text(
                'Święto: $holidayName',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 49, 174, 191),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
          ],
        );
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildNotesListSliver(CalendarState state) {
    final notes = state.notes;
    return notes.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final note = notes[index];
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              note.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 49, 174, 191),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        note.content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () async {
                        final cubit = context.read<CalendarCubit>();
                        final wasModified = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotePage(
                              noteID: note.id,
                              noteDate: note.dateTime,
                            ),
                          ),
                        );
                        if (wasModified == true) {
                          cubit.start();
                        }
                      },
                    ),
                    if (index < notes.length - 1)
                      const Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                  ],
                );
              },
              childCount: notes.length,
            ),
          )
        : SliverFillRemaining(
            child: Center(
              child: Text(
                'Brak notatek',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
  }

  bool _isHoliday(DateTime day, CalendarState state) {
    return state.holidays.any((holiday) {
      final holidayDate = DateTime.parse(holiday.date);
      return isSameDay(holidayDate, day);
    });
  }

  String? _getHolidayName(DateTime day, CalendarState state) {
    try {
      final holiday = state.holidays.firstWhere(
        (holiday) => isSameDay(DateTime.parse(holiday.date), day),
      );
      return holiday.localName;
    } catch (e) {
      return null;
    }
  }
}

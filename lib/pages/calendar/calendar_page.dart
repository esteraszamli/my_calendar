import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/pages/add_note/add_note_page.dart';
import 'package:my_calendar/pages/calendar/calendar_page_widgets.dart';
import 'package:my_calendar/pages/calendar/cubit/calendar_cubit.dart';
import 'package:my_calendar/pages/login/profile_page.dart';
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
        backgroundColor: Color.fromARGB(255, 94, 220, 234).withValues(
          alpha: 30,
        ),
        title: Text(
          'Mój Kalendarz',
          style: GoogleFonts.outfit(fontSize: 23, fontWeight: FontWeight.w400),
        ),
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
            return buildCalendarContent(context, state);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedLabelStyle:
            GoogleFonts.outfit(fontWeight: FontWeight.w400, fontSize: 14),
        unselectedLabelStyle:
            GoogleFonts.outfit(fontWeight: FontWeight.w400, fontSize: 13),
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
        selectedItemColor: const Color.fromARGB(255, 94, 220, 234),
      ),
    );
  }

  Widget buildCalendarContent(BuildContext context, CalendarState state) {
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
                fontSize: 18,
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
                color: Color.fromARGB(255, 94, 220, 234).withValues(
                  alpha: 80,
                ),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 99, 222, 231).withValues(
                  alpha: 140,
                ),
                shape: BoxShape.circle,
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              holidayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 40, 169, 189).withValues(
                  alpha: 100,
                ),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily,
                fontWeight: FontWeight.w400,
              ),
              weekendTextStyle: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 121, 121, 121),
              ),
              holidayTextStyle: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily,
                fontWeight: FontWeight.w400,
                color: Colors.white,
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
            child: buildHolidayInfo(state),
          ),
        buildNotesListSliver(state),
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
          title: DialogTitle(),
          content: DialogContent(),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Anuluj',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
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

  Widget buildHolidayInfo(CalendarState state) {
    if (_selectedDay != null) {
      final holidayName = _getHolidayName(_selectedDay!, state);
      if (holidayName != null) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: HolidayName(holidayName: holidayName),
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

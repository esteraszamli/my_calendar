import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        selectedItemColor: const Color.fromARGB(255, 104, 227, 243),
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
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: TableCalendar(
                      locale: 'pl',
                      firstDay: DateTime(2022),
                      lastDay: DateTime(2030),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                      ),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Color.fromARGB(255, 167, 238, 246),
                          shape: BoxShape.circle,
                        ),
                        defaultDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        holidayDecoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 64, 193)
                              .withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      holidayPredicate: (day) => _isHoliday(day, state),
                      onDaySelected: (selectedDay, focusedDay) {
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
                          if (_dateTapCount == 2) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  actionsAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                selectedDate: selectedDay),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
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
                ];
              },
              body: Column(
                children: [
                  // Dodanie informacji o święcie
                  _buildHolidayInfo(state),
                  Expanded(
                    child: _selectedDay != null
                        ? _buildNotesList(_selectedDay!)
                        : _buildNotesList(DateTime.now()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 0, 162, 183),
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

  // Metody do obsługi świąt
  bool _isHoliday(DateTime day, CalendarState state) {
    return state.holidays.any((holiday) {
      final holidayDate = DateTime.parse(holiday.date);
      return isSameDay(holidayDate, day);
    });
  }

  String? _getHolidayName(DateTime day, CalendarState state) {
    try {
      final holiday = state.holidays.firstWhere(
          (holiday) => isSameDay(DateTime.parse(holiday.date), day));
      return holiday.localName;
    } catch (e) {
      return null;
    }
  }

  // Budowanie listy notatek
  Widget _buildNotesList(DateTime selectedDay) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final notes = state.notes;

        return notes.isNotEmpty
            ? ListView.separated(
                itemCount: notes.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            note.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color.fromARGB(255, 49, 174, 191),
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm').format(note.dateTime),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
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
                  );
                },
              )
            : const Center(
                child: Text('Brak notatek', style: TextStyle(fontSize: 16)),
              );
      },
    );
  }
}

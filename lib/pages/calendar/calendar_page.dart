import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/model/note_model.dart';
import 'package:my_calendar/pages/add_note/add_note_page.dart';
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

  // Prowizoryczna metoda pobierania notatek
  List<NoteModel> _getNotesForDay(DateTime day) {
    // Zaimplementuj pobieranie notatek
    return [];
  }

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
      body: Builder(
        builder: (context) {
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
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _dateTapCount = 1;
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
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color.fromARGB(255, 167, 238, 246),
                        shape: BoxShape.circle,
                      ),
                    ),
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
            body: _selectedDay != null
                ? _buildNotesList(_selectedDay!)
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  // Metoda do budowania listy notatek
  Widget _buildNotesList(DateTime selectedDay) {
    final notes = _getNotesForDay(selectedDay);

    return notes.isNotEmpty
        ? ListView.separated(
            itemCount: notes.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Notatki z dnia: ${selectedDay.toString()}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Implementacja usuwania notatki
                  },
                ),
              );
            },
          )
        : const Center(
            child: Text('Brak notatek', style: TextStyle(fontSize: 16)),
          );
  }
}

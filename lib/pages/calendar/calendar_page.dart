import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/models/holiday_model.dart';
import 'package:my_calendar/models/note_model.dart';
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
        backgroundColor: Color.fromARGB(255, 75, 234, 243),
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
            if (state.isLoading &&
                state.allNotes.isEmpty &&
                state.holidays.isEmpty) {
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        selectedItemColor: const Color.fromARGB(255, 64, 214, 227),
        elevation: 20,
      ),
    );
  }

  Widget buildCalendarContent(BuildContext context, CalendarState state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: RepaintBoundary(
            child: CalendarWidget(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              holidays: state.holidays,
              allNotes: state.allNotes,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
                if (_focusedDay.year != focusedDay.year) {
                  context.read<CalendarCubit>().start(focusedDay);
                }
              },
              onDaySelected: (selectedDay, focusedDay) {
                _handleDaySelection(context, selectedDay, focusedDay);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(
            color: Color.fromARGB(255, 139, 139, 139),
            thickness: 0.5,
            indent: 16,
            endIndent: 16,
          ),
        ),
        if (_selectedDay != null)
          SliverToBoxAdapter(
            child: buildHolidayInfo(state),
          ),

        // Lista notatek z własnym stanem ładowania
        BlocBuilder<CalendarCubit, CalendarState>(
          buildWhen: (previous, current) {
            return previous.notes != current.notes ||
                previous.isLoading != current.isLoading;
          },
          builder: (context, state) {
            if (state.isLoading && _selectedDay != null) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return buildNotesListSliver(state);
          },
        ),
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
      });
      context.read<CalendarCubit>().start(selectedDay);
    } else {
      setState(() {
        _dateTapCount++;
      });
      if (_dateTapCount % 2 == 0) {
        showAddNoteDialog(context, selectedDay);
      }
    }
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

class CalendarWidget extends StatelessWidget {
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final List<HolidayModel> holidays;
  final List<NoteModel> allNotes;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;
  final Function(DateTime, DateTime) onDaySelected;

  const CalendarWidget({
    super.key,
    required this.calendarFormat,
    required this.focusedDay,
    this.selectedDay,
    required this.holidays,
    required this.allNotes,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 48,
      locale: 'pl',
      firstDay: DateTime(2023),
      lastDay: DateTime(2030),
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      daysOfWeekHeight: 20,
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
        return selectedDay != null && isSameDay(selectedDay!, day);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Color.fromARGB(255, 143, 239, 246),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Color.fromARGB(255, 183, 238, 245),
          shape: BoxShape.circle,
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        holidayDecoration: BoxDecoration(
          color: Color.fromARGB(255, 116, 218, 230),
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Color.fromARGB(255, 116, 218, 230),
          shape: BoxShape.circle,
        ),
        markersMaxCount: 1,
        markerSize: 8,
        markerMargin: const EdgeInsets.only(top: 8),
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
      holidayPredicate: (day) => _isHoliday(day),
      eventLoader: (day) {
        return _hasNotesForDay(day) ? ['note'] : [];
      },
      onDaySelected: onDaySelected,
      onFormatChanged: onFormatChanged,
      onPageChanged: onPageChanged,
    );
  }

  bool _isHoliday(DateTime day) {
    return holidays.any((holiday) {
      final holidayDate = DateTime.parse(holiday.date);
      return isSameDay(holidayDate, day);
    });
  }

  bool _hasNotesForDay(DateTime day) {
    return allNotes.any((note) =>
        note.dateTime.year == day.year &&
        note.dateTime.month == day.month &&
        note.dateTime.day == day.day);
  }
}

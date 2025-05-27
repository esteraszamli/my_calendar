import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/add_note/add_note_page.dart';
import 'package:my_calendar/pages/calendar/cubit/calendar_cubit.dart';
import 'package:my_calendar/pages/note/note_page.dart';
import 'package:my_calendar/styles/calendar_styles.dart';

Widget buildNotesListSliver(CalendarState state) {
  final notes = state.notes;

  if (notes.isEmpty) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          'Brak notatek',
          style: AppStyles.noteContent,
        ),
      ),
    );
  }

  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        final note = notes[index];
        return Column(
          children: [
            ListTile(
              title: Text(
                note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.noteTitle,
              ),
              subtitle: Text(
                note.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.noteContent,
              ),
              onTap: () => _handleNoteTap(context, note),
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
  );
}

Future<void> _handleNoteTap(BuildContext context, NoteModel note) async {
  final cubit = context.read<CalendarCubit>();
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NotePage(
        noteID: note.id,
        noteDate: note.dateTime,
      ),
    ),
  );
  if (!context.mounted) return;
  if (result == true) {
    cubit.start(note.dateTime);
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Czy chcesz utworzyć nową notatkę?',
      style: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class DialogTitle extends StatelessWidget {
  const DialogTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Stwórz notatkę',
      style: GoogleFonts.outfit(
        fontSize: 23,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class HolidayName extends StatelessWidget {
  const HolidayName({
    super.key,
    required this.holidayName,
  });

  final String? holidayName;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Święto: $holidayName',
      style: GoogleFonts.outfit(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 49, 174, 191),
      ),
    );
  }
}

void showAddNoteDialog(BuildContext context, DateTime selectedDay) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.spaceAround,
        title: Text(
          'Stwórz notatkę',
          style: GoogleFonts.outfit(
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Czy chcesz utworzyć nową notatkę?',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundColor: Color.fromARGB(255, 63, 204, 222),
            ),
            child: Text(
              'Anuluj',
              style: GoogleFonts.outfit(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 48, 166, 188),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundColor: Color.fromARGB(255, 63, 204, 222),
            ),
            child: Text(
              'Ok',
              style: GoogleFonts.outfit(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 48, 166, 188),
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotePage(
                    selectedDate: DateTime(
                      selectedDay.year,
                      selectedDay.month,
                      selectedDay.day,
                    ),
                  ),
                ),
              );
              if (context.mounted &&
                  result != null &&
                  result is Map<String, dynamic>) {
                if (result['wasModified'] == true) {
                  final dateToRefresh = result['selectedDate'] ?? selectedDay;
                  context.read<CalendarCubit>().start(dateToRefresh);
                }
              }
            },
          ),
        ],
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/add_note/add_note_page.dart';
import 'package:my_calendar/pages/calendar/cubit/calendar_cubit.dart';
import 'package:my_calendar/pages/note/note_page.dart';
import 'package:my_calendar/theme/responsive_theme.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildNotesListSliver(CalendarState state) {
  final notes = state.notes;

  if (notes.isEmpty) {
    return SliverFillRemaining(
      child: Builder(
        builder: (context) {
          final scale = ResponsiveTheme.scale(context);
          return Center(
            child: Text(
              'Brak notatek',
              style: GoogleFonts.outfit(
                fontSize: ResponsiveTheme.isMobile(context) ? 15 : 15 * scale,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
      ),
    );
  }

  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        final scale = ResponsiveTheme.scale(context);
        final note = notes[index];
        return Column(
          children: [
            ListTile(
              title: Text(
                note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: ResponsiveTheme.isMobile(context) ? 17 : 17 * scale,
                  fontWeight: FontWeight.w600,
                  color: ResponsiveTheme.noteColor,
                ),
              ),
              subtitle: Text(
                note.content,
                maxLines: ResponsiveTheme.isTablet7(context) ||
                        ResponsiveTheme.isTablet10(context)
                    ? 2
                    : 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: ResponsiveTheme.isMobile(context) ? 15 : 15 * scale,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () => _handleNoteTap(context, note),
            ),
            if (index < notes.length - 1)
              Divider(
                height: ResponsiveTheme.isMobile(context) ? 1 : 1 * scale,
                thickness: ResponsiveTheme.isMobile(context)
                    ? 0.5
                    : (ResponsiveTheme.isTablet7(context) ? 1.0 : 1.5),
                indent: ResponsiveTheme.isMobile(context) ? 16 : 16 * scale,
                endIndent: ResponsiveTheme.isMobile(context) ? 16 : 16 * scale,
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
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Czy chcesz utworzyć nową notatkę?',
      style: GoogleFonts.outfit(
        fontSize: ResponsiveTheme.isMobile(context) ? 16 : 16 * scale,
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
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Stwórz notatkę',
      style: GoogleFonts.outfit(
        fontSize: ResponsiveTheme.isMobile(context) ? 23 : 23 * scale,
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
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Święto: $holidayName',
      style: GoogleFonts.outfit(
        fontSize: ResponsiveTheme.isMobile(context) ? 17 : 17 * scale,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: ResponsiveTheme.noteColor,
      ),
    );
  }
}

void showAddNoteDialog(BuildContext context, DateTime selectedDay) {
  final scale = ResponsiveTheme.scale(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.spaceAround,
        contentPadding: ResponsiveTheme.isMobile(context)
            ? null
            : EdgeInsets.all(16 * scale),
        actionsPadding: ResponsiveTheme.isMobile(context)
            ? null
            : EdgeInsets.all(16 * scale),
        title: Text(
          'Stwórz notatkę',
          style: GoogleFonts.outfit(
            fontSize: ResponsiveTheme.isMobile(context) ? 23 : 23 * scale,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Czy chcesz utworzyć nową notatkę?',
          style: GoogleFonts.outfit(
            fontSize: ResponsiveTheme.isMobile(context) ? 16 : 16 * scale,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundColor: const Color.fromARGB(255, 63, 204, 222),
              padding: ResponsiveTheme.isMobile(context)
                  ? null
                  : EdgeInsets.symmetric(
                      horizontal: 16 * scale,
                      vertical: 8 * scale,
                    ),
            ),
            child: Text(
              'Anuluj',
              style: GoogleFonts.outfit(
                fontSize: ResponsiveTheme.isMobile(context) ? 17 : 17 * scale,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 48, 166, 188),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundColor: const Color.fromARGB(255, 63, 204, 222),
              padding: ResponsiveTheme.isMobile(context)
                  ? null
                  : EdgeInsets.symmetric(
                      horizontal: 16 * scale,
                      vertical: 8 * scale,
                    ),
            ),
            child: Text(
              'Ok',
              style: GoogleFonts.outfit(
                fontSize: ResponsiveTheme.isMobile(context) ? 17 : 17 * scale,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 48, 166, 188),
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

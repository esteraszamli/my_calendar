import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/pages/edit_note/edit_note_page.dart';
import 'package:my_calendar/pages/note/cubit/note_cubit.dart';
import 'package:my_calendar/theme/responsive_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class NotePage extends StatelessWidget {
  final String noteID;
  final DateTime noteDate;

  const NotePage({super.key, required this.noteID, required this.noteDate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCubit>(
      create: (context) =>
          getIt<NoteCubit>()..getNoteDetails(noteID.toString()),
      child: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state.noteDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Notatka została usunięta',
                  style:
                      _noteContentStyle(context).copyWith(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 70, 70, 70),
              ),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state.noteDeletedLocally) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Notatka została usunięta lokalnie. Czekam na połączenie z internetem',
                  style:
                      _noteContentStyle(context).copyWith(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 70, 70, 70),
              ),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          final scale = ResponsiveTheme.scale(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: ResponsiveTheme.primaryColor,
              toolbarHeight: ResponsiveTheme.isMobile(context)
                  ? null
                  : kToolbarHeight * scale,
              leading: ResponsiveTheme.isMobile(context)
                  ? null
                  : IconButton(
                      icon: Icon(Icons.arrow_back, size: 24 * scale),
                      onPressed: () {
                        Navigator.of(context).pop(state.noteUpdated);
                      },
                    ),
              title: _Title(noteDate: noteDate),
              actions: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit,
                          size: ResponsiveTheme.isMobile(context)
                              ? 24
                              : 24 * scale),
                      onPressed: state.note != null
                          ? () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditNotePage(note: state.note!),
                                ),
                              );
                              if (result == true && context.mounted) {
                                await context
                                    .read<NoteCubit>()
                                    .getNoteDetails(noteID.toString());
                                if (context.mounted) {
                                  context.read<NoteCubit>().markAsUpdated();
                                }
                              }
                            }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete,
                          size: ResponsiveTheme.isMobile(context)
                              ? 24
                              : 24 * scale),
                      onPressed: () => _showDeleteConfirmationDialog(context),
                    ),
                  ],
                ),
              ],
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, NoteState state) {
    final scale = ResponsiveTheme.scale(context);

    if (state.isLoading) {
      return Center(
        child: SizedBox(
          width: 50 * scale,
          height: 50 * scale,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Text(
          'Błąd: ${state.errorMessage}',
          style: _noteContentStyle(context).copyWith(
            color: const Color.fromARGB(255, 208, 76, 63),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.note?.title ?? 'Brak tytułu',
              style: _textStyle(context,
                  fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20 * scale),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 55, 178, 200),
                  width: 1.5 * scale,
                ),
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Text(
                state.note?.content ?? 'Brak treści',
                style: _noteContentStyle(context),
              ),
            ),
            SizedBox(height: 20 * scale),
            if (state.note != null)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Data: ${DateFormat('dd.MM.yyyy').format(state.note!.dateTime)}',
                  style: _textStyle(
                    context,
                    fontSize: 15,
                    color: const Color.fromARGB(255, 48, 166, 188),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<NoteCubit>(),
        child: AlertDialog(
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.spaceAround,
          contentPadding: EdgeInsets.all(16 * scale),
          actionsPadding: EdgeInsets.all(16 * scale),
          title: Text(
            'Usunąć notatkę?',
            style: _dialogTitleStyle(context),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Czy na pewno chcesz usunąć notatkę?',
            style: _dialogContentStyle(context),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 63, 204, 222),
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * scale,
                  vertical: 8 * scale,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Anuluj', style: _buttonTextStyle(context)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 63, 204, 222),
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * scale,
                  vertical: 8 * scale,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await context.read<NoteCubit>().deleteNote(noteID);
              },
              child: Text('Usuń', style: _buttonTextStyle(context)),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle(
    BuildContext context, {
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    final scale = ResponsiveTheme.scale(context);
    return GoogleFonts.outfit(
      fontSize: fontSize * scale,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
    );
  }

  TextStyle _noteContentStyle(BuildContext context) =>
      _textStyle(context, fontSize: 16, fontWeight: FontWeight.w400);

  TextStyle _dialogTitleStyle(BuildContext context) =>
      _textStyle(context, fontSize: 23, fontWeight: FontWeight.w400);

  TextStyle _dialogContentStyle(BuildContext context) =>
      _textStyle(context, fontSize: 16, fontWeight: FontWeight.w400);

  TextStyle _buttonTextStyle(BuildContext context) => _textStyle(
        context,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 48, 166, 188),
      );
}

class _Title extends StatelessWidget {
  const _Title({
    required this.noteDate,
  });

  final DateTime noteDate;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Notatka – ${DateFormat('dd.MM.yy').format(noteDate)}',
      style: GoogleFonts.outfit(
        fontSize: 23 * scale,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

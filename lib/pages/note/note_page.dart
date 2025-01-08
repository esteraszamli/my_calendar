import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/pages/edit_note/edit_note_page.dart';
import 'package:my_calendar/pages/note/cubit/note_cubit.dart';

class NotePage extends StatelessWidget {
  final String noteID;
  final DateTime noteDate;

  const NotePage({super.key, required this.noteID, required this.noteDate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCubit>(
      create: (context) =>
          getIt<NoteCubit>()..getNoteDetails(noteID.toString()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 99, 222, 231),
          title: _Title(noteDate: noteDate),
          actions: [
            BlocConsumer<NoteCubit, NoteState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: state.note != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditNotePage(note: state.note!),
                                ),
                              ).then((_) {
                                if (context.mounted) {
                                  context
                                      .read<NoteCubit>()
                                      .getNoteDetails(noteID.toString());
                                }
                              });
                            }
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _showDeleteConfirmationDialog(context),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(
                child: Text(
                  'Błąd: ${state.errorMessage}',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 208, 76, 63),
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.note?.title ?? 'Brak tytułu',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 109, 223, 238),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        state.note?.content ?? 'Brak treści',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Data: ${DateFormat('dd.MM.yyyy').format(state.note!.dateTime)}',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          color: Color.fromARGB(255, 49, 174, 191),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<NoteCubit>(),
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: Text(
            'Usunąć notatkę?',
            style: GoogleFonts.outfit(
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Text(
            'Czy na pewno chcesz usunąć notatkę?',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Anuluj',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await context.read<NoteCubit>().deleteNote(noteID);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      'Notatka została usunięta',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  );

                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              child: Text(
                'Usuń',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.noteDate,
  });

  final DateTime noteDate;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Notatka – ${DateFormat('dd.MM.yy').format(noteDate)}',
      style: GoogleFonts.outfit(
        fontSize: 23,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

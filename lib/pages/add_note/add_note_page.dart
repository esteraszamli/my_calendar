import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/pages/add_note/cubit/add_note_cubit.dart';

class AddNotePage extends StatefulWidget {
  final DateTime selectedDate;

  const AddNotePage({super.key, required this.selectedDate});

  @override
  AddNotePageState createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 99, 222, 231),
          title: Text(
            'Nowa notatka – ${DateFormat('dd.MM.yy').format(widget.selectedDate)}',
            style: GoogleFonts.outfit(
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: BlocProvider<AddNoteCubit>(
            create: (context) =>
                getIt<AddNoteCubit>(param1: widget.selectedDate),
            child: BlocConsumer<AddNoteCubit, AddNoteState>(
              listener: (context, state) {
                if (state.noteAdded == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Notatka zapisana!',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      backgroundColor: Color.fromARGB(255, 107, 215, 152),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      'Błąd zapisu: ${state.errorMessage}',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titleController,
                          maxLines: 1,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Tytuł...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 60, 215, 235),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 109, 223, 238),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 49, 174, 191),
                                width: 2.0,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(35),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _contentController,
                          maxLines: 20,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Treść notatki...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 60, 215, 235),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 109, 223, 238),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 49, 174, 191),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: state.isLoading
                                  ? null
                                  : () {
                                      context.read<AddNoteCubit>().updateField(
                                          'title', _titleController.text);
                                      context.read<AddNoteCubit>().updateField(
                                          'content', _contentController.text);
                                      context.read<AddNoteCubit>().addNote();
                                    },
                              child: state.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Zapisz',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 39, 206, 225),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

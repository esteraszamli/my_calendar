import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/pages/add_note/cubit/add_note_cubit.dart';
import 'package:my_calendar/theme/responsive_theme.dart';

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
    final scale = ResponsiveTheme.scale(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ResponsiveTheme.primaryColor,
        toolbarHeight:
            ResponsiveTheme.isMobile(context) ? null : kToolbarHeight * scale,
        leading: ResponsiveTheme.isMobile(context)
            ? null
            : IconButton(
                icon: Icon(Icons.arrow_back, size: 24 * scale),
                onPressed: () => Navigator.of(context).pop(),
              ),
        title: _Title(widget: widget),
      ),
      body: BlocProvider<AddNoteCubit>(
        create: (context) => getIt<AddNoteCubit>(param1: widget.selectedDate),
        child: BlocConsumer<AddNoteCubit, AddNoteState>(
          listener: (context, state) {
            if (state.noteAdded == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Notatka zapisana!',
                    style:
                        _textStyle(context, fontSize: 15, color: Colors.white),
                  ),
                  backgroundColor: const Color.fromARGB(255, 107, 215, 152),
                ),
              );
              Navigator.pop(context,
                  {'wasModified': true, 'selectedDate': widget.selectedDate});
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Błąd zapisu: ${state.errorMessage}',
                    style: _textStyle(context, fontSize: 15),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleField(titleController: _titleController),
                    SizedBox(height: 20 * scale),
                    _ContentField(contentController: _contentController),
                    SizedBox(height: 20 * scale),
                    Padding(
                      padding: EdgeInsets.only(right: 16.0 * scale),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 248, 248, 248),
                            foregroundColor:
                                const Color.fromARGB(255, 63, 204, 222),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20 * scale,
                              vertical: 12 * scale,
                            ),
                          ),
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
                              ? SizedBox(
                                  width: 20 * scale,
                                  height: 20 * scale,
                                  child: const CircularProgressIndicator(),
                                )
                              : _SaveButton(),
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

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Zapisz',
      style: GoogleFonts.outfit(
        fontSize: 16 * scale,
        color: const Color.fromARGB(255, 39, 206, 225),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ContentField extends StatelessWidget {
  const _ContentField({
    required TextEditingController contentController,
  }) : _contentController = contentController;

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return TextField(
      controller: _contentController,
      maxLines: 20,
      style: GoogleFonts.outfit(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: 'Treść notatki...',
        hintStyle: GoogleFonts.outfit(
          fontSize: 16 * scale,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.all(12 * scale),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 60, 215, 235),
            width: 1.5 * scale,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 73, 237, 245),
            width: 1.5 * scale,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 49, 174, 191),
            width: 2.0 * scale,
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return TextField(
      controller: _titleController,
      maxLines: 1,
      style: GoogleFonts.outfit(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: 'Tytuł...',
        hintStyle: GoogleFonts.outfit(
          fontSize: 16 * scale,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.all(12 * scale),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 60, 215, 235),
            width: 1.5 * scale,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 109, 223, 238),
            width: 1.5 * scale,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 49, 174, 191),
            width: 2.0 * scale,
          ),
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(35),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.widget,
  });

  final AddNotePage widget;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Nowa notatka – ${DateFormat('dd.MM.yy').format(widget.selectedDate)}',
      style: GoogleFonts.outfit(
        fontSize: 23 * scale,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

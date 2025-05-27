import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/edit_note/cubit/edit_note_cubit.dart';

class EditNotePage extends StatelessWidget {
  final NoteModel note;

  const EditNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditNoteCubit>(param1: note),
      child: const _EditRecipeView(),
    );
  }
}

class _EditRecipeView extends StatelessWidget {
  const _EditRecipeView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditNoteCubit, EditNoteState>(
      listener: (context, state) {
        if (state.noteUpdated) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: _UpdatedNote(),
              backgroundColor: Color.fromARGB(255, 107, 215, 152),
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 208, 76, 63),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 75, 234, 243),
            title: _EditNote(),
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _EditNoteForm(),
        );
      },
    );
  }
}

class _EditNote extends StatelessWidget {
  const _EditNote();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Edytuj notatkę',
      style: GoogleFonts.outfit(
        fontSize: 23,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _UpdatedNote extends StatelessWidget {
  const _UpdatedNote();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Notatka zaktualizowana!',
      style: GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}

class _EditNoteForm extends StatefulWidget {
  @override
  _EditNoteFormState createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<_EditNoteForm> {
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    final state = context.read<EditNoteCubit>().state;
    _controllers = {
      'title': TextEditingController(text: state.title),
      'content': TextEditingController(text: state.content),
    };
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditNoteCubit>().state;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              label: 'Tytuł',
              controller: _controllers['title']!,
              onChanged: (value) =>
                  context.read<EditNoteCubit>().updateField('title', value),
              maxLines: 1,
              inputFormatters: [LengthLimitingTextInputFormatter(35)],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Treść notatki',
              controller: _controllers['content']!,
              onChanged: (value) =>
                  context.read<EditNoteCubit>().updateField('content', value),
              maxLines: 20,
            ),
            const SizedBox(height: 20),
            _SaveNote(state: state),
          ],
        ),
      ),
    );
  }
}

class _SaveNote extends StatelessWidget {
  const _SaveNote({
    required this.state,
  });

  final EditNoteState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            foregroundColor: Color.fromARGB(255, 63, 204, 222),
          ),
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<EditNoteCubit>().updateNote();
                },
          child: state.isLoading
              ? const CircularProgressIndicator()
              : const Text(
                  'Zapisz',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 39, 206, 225),
                  ),
                ),
        ),
      ),
    );
  }
}

Widget _buildTextField({
  required String label,
  required TextEditingController controller,
  required void Function(String) onChanged,
  inputFormatters,
  int? minLines,
  int? maxLines,
}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    minLines: minLines,
    maxLines: maxLines ?? 1,
    style: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    decoration: InputDecoration(
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
          color: Color.fromARGB(255, 73, 237, 245),
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
      label: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 73, 237, 245),
        ),
      ),
    ),
  );
}

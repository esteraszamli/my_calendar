import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/edit_note/cubit/edit_note_cubit.dart';
import 'package:my_calendar/theme/responsive_theme.dart';

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
    final scale = ResponsiveTheme.scale(context);

    return BlocConsumer<EditNoteCubit, EditNoteState>(
      listener: (context, state) {
        if (state.noteUpdated) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: _UpdatedNote(),
              backgroundColor: const Color.fromARGB(255, 107, 215, 152),
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
                style: _textStyle(context,
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              backgroundColor: const Color.fromARGB(255, 208, 76, 63),
            ),
          );
        }
      },
      builder: (context, state) {
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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
            title: _EditNote(),
          ),
          body: state.isLoading
              ? Center(
                  child: SizedBox(
                    width: 50 * scale,
                    height: 50 * scale,
                    child: const CircularProgressIndicator(),
                  ),
                )
              : _EditNoteForm(),
        );
      },
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
}

class _EditNote extends StatelessWidget {
  const _EditNote();

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Edytuj notatkę',
      style: GoogleFonts.outfit(
        fontSize: 23 * scale,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _UpdatedNote extends StatelessWidget {
  const _UpdatedNote();

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Notatka zaktualizowana!',
      style: GoogleFonts.outfit(
        fontSize: 15 * scale,
        fontWeight: FontWeight.w400,
        color: const Color.fromARGB(255, 255, 255, 255),
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
    final scale = ResponsiveTheme.scale(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              context: context,
              label: 'Tytuł',
              controller: _controllers['title']!,
              onChanged: (value) =>
                  context.read<EditNoteCubit>().updateField('title', value),
              maxLines: 1,
              inputFormatters: [LengthLimitingTextInputFormatter(35)],
            ),
            SizedBox(height: 20 * scale),
            _buildTextField(
              context: context,
              label: 'Treść notatki',
              controller: _controllers['content']!,
              onChanged: (value) =>
                  context.read<EditNoteCubit>().updateField('content', value),
              maxLines: 20,
            ),
            SizedBox(height: 20 * scale),
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
    final scale = ResponsiveTheme.scale(context);

    return Padding(
      padding: EdgeInsets.only(right: 16.0 * scale),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            foregroundColor: const Color.fromARGB(255, 63, 204, 222),
            padding: EdgeInsets.symmetric(
              horizontal: 20 * scale,
              vertical: 12 * scale,
            ),
          ),
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<EditNoteCubit>().updateNote();
                },
          child: state.isLoading
              ? SizedBox(
                  width: 20 * scale,
                  height: 20 * scale,
                  child: const CircularProgressIndicator(),
                )
              : Text(
                  'Zapisz',
                  style: GoogleFonts.outfit(
                    fontSize: 16 * scale,
                    color: const Color.fromARGB(255, 39, 206, 225),
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

Widget _buildTextField({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required void Function(String) onChanged,
  List<TextInputFormatter>? inputFormatters,
  int? minLines,
  int? maxLines,
}) {
  final scale = ResponsiveTheme.scale(context);

  return TextField(
    controller: controller,
    onChanged: onChanged,
    minLines: minLines,
    maxLines: maxLines ?? 1,
    inputFormatters: inputFormatters,
    style: GoogleFonts.outfit(
      fontSize: 16 * scale,
      fontWeight: FontWeight.w400,
    ),
    decoration: InputDecoration(
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
      label: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 18 * scale,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 73, 237, 245),
        ),
      ),
    ),
  );
}

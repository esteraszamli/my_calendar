import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:my_calendar/model/note_model.dart';
import 'package:my_calendar/pages/edit_note/cubit/edit_note_cubit.dart';

class EditNotePage extends StatelessWidget {
  final NoteModel note;

  const EditNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditNoteCubit>(),
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
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notatka zaktualizowana!'),
              backgroundColor: Colors.green,
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edytuj notatkę'),
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _EditNoteForm(),
        );
      },
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
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
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
            ),
          ],
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
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(label),
    ),
  );
}

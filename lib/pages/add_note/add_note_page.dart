import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNotePage extends StatefulWidget {
  final DateTime selectedDate;

  const AddNotePage({super.key, required this.selectedDate});

  @override
  AddNotePageState createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Nowa notatka – ${DateFormat('dd.MM.yy').format(widget.selectedDate)}',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Tytuł...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintText: 'Treść notatki...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 20,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Tu będzie implementacja zapisu notatki
                        ('Notatka: ${_titleController.text}');
                        Navigator.pop(context);
                      },
                      child:
                          const Text('Zapisz', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}

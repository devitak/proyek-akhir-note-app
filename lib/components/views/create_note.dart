import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:note_bucket/components/model/note.dart';
import 'package:note_bucket/components/res/assets.dart';
import 'package:note_bucket/components/services/local_db.dart';
import 'package:intl/intl.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime.toLocal());
  }
  final localDb = LocalDBService();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffF8F8F8),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  widget.note != null
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        localDb.deleteNote(id: widget.note!.id);
                        Navigator.pop(context);
                      },
                    ),
                  )
                      : const SizedBox.shrink(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Title",
                    filled: true,
                    fillColor: Color(0xffffa5a5),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Description",
                    filled: true,
                    fillColor: Color(0xffffa5a5),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (widget.note != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Last modified: ${_formatDateTime(widget.note!.lastMod)}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          _saveNote();
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Color(0xffffa5a5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _saveNote() {
    final title = _titleController.text;
    final desc = _descriptionController.text;

    if (title.isNotEmpty || desc.isNotEmpty) {
      final currentTime = DateTime.now();
      final newNote = Note(
        id: currentTime.millisecondsSinceEpoch,
        title: title,
        description: desc,
        lastMod: currentTime,
      );
      localDb.saveNote(note: newNote);

      Navigator.pop(context);
    }
  }
}
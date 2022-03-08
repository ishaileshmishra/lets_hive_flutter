import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_in_flutter/src/constant.dart';

import '../models/note_model.dart';
import '../models/timedetail_model.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key, this.noteItem, this.noteIndex})
      : super(key: key);

  final noteIndex;
  final noteItem;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController(text: "");
  final _descController = TextEditingController(text: "");
  final _tagController = TextEditingController(text: "");

  String? timeDetial;
  Note? noteItem;

  @override
  void initState() {
    noteItem = widget.noteItem;
    if (noteItem != null) {
      _titleController.text = noteItem!.title;
      _descController.text = noteItem!.desc;
      _tagController.text =
          noteItem!.tags.toString().replaceAll("]", "").replaceAll("[", "");
      timeDetial =
          "Created : ${noteItem!.timeDetail.createdAt}  Updated : ${noteItem!.timeDetail.updatedAt}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var screenHeight = MediaQuery.of(context).size.height;
    Box<Note> noteBox = Hive.box<Note>(hiveDatabase);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Add New Note',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            autofocus: true,
            controller: _titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(hintText: "Description"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _tagController,
            decoration: const InputDecoration(hintText: "Tags"),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              child: const Text('Save Note'),
              onPressed: () {
                var title = _titleController.text;
                var desc = _descController.text;
                List<String> tagsList = _tagController.text.split(",");

                var timedetail = TimeDetail(
                    noteItem == null
                        ? DateTime.now()
                        : noteItem!.timeDetail.createdAt,
                    DateTime.now());
                var finalNote = Note(title, desc, tagsList, timedetail);
                noteItem == null
                    ? noteBox.add(finalNote)
                    : noteBox.putAt(widget.noteIndex, finalNote);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

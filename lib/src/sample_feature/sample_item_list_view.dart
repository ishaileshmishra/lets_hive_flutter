import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_in_flutter/src/notes/new_note.dart';

import '../constant.dart';
import '../models/note_model.dart';

/// Displays a list of SampleItems.
class SavedNotes extends StatelessWidget {
  const SavedNotes({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    Box<Note> noteBox = Hive.box<Note>(hiveDatabase);
    var notes = noteBox.toMap().entries;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNote(context);
        },
        // showTheModelPopup
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text('Notes',
            style: GoogleFonts.aclonica(
              textStyle: const TextStyle(
                color: Colors.white,
                letterSpacing: .5,
                fontSize: 30,
              ),
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              //Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Container(
        color: Colors.grey.shade100,
        child: ValueListenableBuilder(
          valueListenable: noteBox.listenable(),
          builder: (context, Box<Note> noteBox, _) {
            return noteBox.isEmpty
                ? Container()
                : ListView.builder(
                    restorationId: 'sampleItemListView',
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      var noteItem = noteBox.getAt(index);
                      return ListTile(
                        title: Text(
                          noteItem!.title,
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        subtitle: Text(
                          noteItem.desc,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        leading: const CircleAvatar(
                          child: Icon(
                            Icons.note_add_sharp,
                            size: 20,
                            color: Color.fromARGB(255, 61, 28, 138),
                          ),
                        ),
                        trailing: const Icon(Icons.more_vert),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  _addNote(BuildContext _context) {
    showModalBottomSheet<void>(
      context: _context,
      builder: (BuildContext context) {
        return const AddNoteScreen();
      },
    );
  }
}

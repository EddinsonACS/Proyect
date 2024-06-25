import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primerospasosapp/models/blog/note_model.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  const NoteScreen({super.key, required this.note});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Note note;
  String titleString = '';
  String noteString = '';
  late int color;

  final CollectionReference myNotes =
      FirebaseFirestore.instance.collection('notes');

  late TextEditingController titleController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    note = widget.note;
    titleString = note.title;
    noteString = note.note;
    color = note.color == 0xFFFFFFFF ? generateRandomLightColor() : note.color;
    titleController = TextEditingController(text: titleString);
    noteController = TextEditingController(text: noteString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xA9037584),
                    ),
                    child: const BackButton(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    note.id.isEmpty ? 'Nueva Nota' : 'Editar Nota',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xA9037584),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            saveNotes();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.save_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        if (note.id.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              myNotes.doc(note.id).delete();
                              Navigator.pop(context);
                            },
                            padding: const EdgeInsets.all(10.0),
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xA9037584))),
                  border: InputBorder.none,
                  hintText: "Titulo",
                ),
                onChanged: (value) {
                  titleString = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TextField(
                  controller: noteController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xA9037584))),
                    border: InputBorder.none,
                    hintText: "Contenido",
                  ),
                  onChanged: (value) {
                    noteString = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int generateRandomLightColor() {
    Random random = Random();
    int red = 200 + random.nextInt(56); // 200 to 255
    int green = 200 + random.nextInt(56); // 200 to 255
    int blue = 200 + random.nextInt(56); // 200 to 255
    return (0xFF << 24) | (red << 16) | (green << 8) | blue;
  }

  // for save and update the notes
  void saveNotes() async {
    DateTime now = DateTime.now();
    if (note.id.isEmpty) {
      await myNotes.add({
        'title': titleString,
        'note': noteString,
        'color': color,
        'createdAt': now,
      });
    } else {
      await myNotes.doc(note.id).update({
        'title': titleString,
        'note': noteString,
        'color': color,
        'updatedAt': now,
      });
    }
  }
}

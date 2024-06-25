import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:primerospasosapp/models/blog/note_model.dart';

class NoteScreenRepr extends StatelessWidget {
  final Note note;
  const NoteScreenRepr({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    DateTime displayTime = note.updatedAt.isAfter(note.createdAt)
        ? note.updatedAt
        : note.createdAt;

    String formattedDateTime =
        DateFormat('h:mma MMMM d, y').format(displayTime);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Center(
                    child: Text(
                      'Actividades',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Container(), // Aquí puedes dejar vacío o poner un widget según tu diseño
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                note.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                note.note,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                formattedDateTime,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

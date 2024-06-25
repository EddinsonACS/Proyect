import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primerospasosapp/models/blog/note_model.dart';
import 'package:primerospasosapp/screens/repr/actividades_repr/note_cardr_repr.dart';
import 'package:primerospasosapp/screens/repr/home_screen_repr.dart';

import '../../../widgets/widgets.dart';
import 'note_screen_repr.dart';

class ActividadesScreenRepr extends StatefulWidget {
  const ActividadesScreenRepr({super.key});

  @override
  State<ActividadesScreenRepr> createState() => _ActividadesScreenRepr();
}

class _ActividadesScreenRepr extends State<ActividadesScreenRepr> {
  final CollectionReference myNotes =
      FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 170),
            child: ListView(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: myNotes.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final notes = snapshot.data!.docs;
                      List<NoteCardRepr> noteCards = [];
                      for (var note in notes) {
                        var data = note.data() as Map<String, dynamic>?;
                        if (data != null) {
                          Note noteObject = Note(
                            id: note.id,
                            title: data['title'] ?? "",
                            note: data['note'] ?? "",
                            createdAt: data.containsKey('createdAt')
                                ? (data['createdAt'] as Timestamp).toDate()
                                : DateTime.now(),
                            updatedAt: data.containsKey('updatedAt')
                                ? (data['updatedAt'] as Timestamp).toDate()
                                : DateTime.now(),
                            color: data.containsKey('color')
                                ? data['color']
                                : 0xFFFFFFFF,
                          );
                          noteCards.add(
                            NoteCardRepr(
                              note: noteObject,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NoteScreenRepr(note: noteObject),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: noteCards.length,
                        itemBuilder: (context, index) {
                          return noteCards[index];
                        },
                        padding: const EdgeInsets.all(3),
                      );
                    })
              ],
            ),
          ),
          const _Encabezado2()
        ],
      ),
    );
  }
}

class _Encabezado2 extends StatelessWidget {
  const _Encabezado2();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const IconHeader2(
          icon: Icons.note_add_rounded,
          titulo: 'Actividades',
        ),
        Positioned(
            left: 10,
            top: 50,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreenRepr()));
              },
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15.0),
              child: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 40,
              ),
            ))
      ],
    );
  }
}

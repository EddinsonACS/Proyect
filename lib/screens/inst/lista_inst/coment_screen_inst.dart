import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComentScreenInst extends StatefulWidget {
  const ComentScreenInst({
    super.key,
    required this.onSaveComment,
    required List savedComments,
  });

  final Function(String) onSaveComment;

  @override
  // ignore: library_private_types_in_public_api
  _ComentScreenInstState createState() => _ComentScreenInstState();
}

class _ComentScreenInstState extends State<ComentScreenInst> {
  final TextEditingController _commentController = TextEditingController();
  String?
      _commentDocId; // Variable para almacenar el ID del documento del comentario actual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Actividades',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xA9037584),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Actividad:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Ingresa la Actividad',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final String comment = _commentController.text.trim();
                if (comment.isNotEmpty) {
                  String docId = await _saveComment(comment);
                  setState(() {
                    _commentDocId = docId;
                  });
                  widget.onSaveComment(comment);
                  _commentController.clear(); // Limpiar el campo de texto
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Comentario:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildComment(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment() {
    if (_commentDocId == null || _commentDocId!.isEmpty) {
      return const Center(child: Text('Aún no hay Comentario guardado.'));
    }

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .doc(_commentDocId!)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return const Center(child: Text('El comentario no existe.'));
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        String comment = data['comment'];

        return ListTile(
          title: Text(comment),
        );
      },
    );
  }

  Future<String> _saveComment(String comment) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('comments').add({
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
    });
    return docRef.id; // Devuelve el ID del documento creado
  }
}

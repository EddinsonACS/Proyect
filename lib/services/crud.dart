import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        // ignore: body_might_complete_normally_catch_error
        .catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("blogs").snapshots();
  }

  Future<void> deleteImageFromStorageAndFirestore(String imgUrl) async {
    try {
      // Eliminar la imagen de Firebase Storage
      Reference reference = FirebaseStorage.instance.refFromURL(imgUrl);
      await reference.delete();

      // Eliminar la referencia del documento que contiene la URL de la imagen de Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("blogs")
          .where("imgUrl", isEqualTo: imgUrl)
          .get();

      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      // ignore: avoid_print
      print('Imagen eliminada de Firebase Storage y Firestore correctamente.');
    } catch (e) {
      // ignore: avoid_print
      print('Error al eliminar la imagen de Firebase Storage y Firestore: $e');
    }
  }
}

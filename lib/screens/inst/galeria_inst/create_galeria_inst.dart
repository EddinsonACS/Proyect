import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:primerospasosapp/services/crud.dart';
import 'package:random_string/random_string.dart';

class CreateGaleriaInst extends StatefulWidget {
  const CreateGaleriaInst({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateGaleriaInst> {
  late String authorName, title, desc;
  File? selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = CrudMethods();

  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print('No image selected.');
      }
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      // ignore: avoid_print
      print("this is url $downloadUrl");

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Imagen",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        backgroundColor: const Color(0xA9037584),
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(
                  Icons.file_upload,
                  color: Colors.black,
                  size: 30,
                )),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: const Color(0xA9037584),
                                  borderRadius: BorderRadius.circular(6)),
                              width: MediaQuery.of(context).size.width,
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 50,
                              ),
                            )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xA9037584))),
                            hintText: "Identificación:",
                          ),
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: "Descripción:",
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xA9037584))),
                          ),
                          onChanged: (val) {
                            desc = val;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: "Titulo:",
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xA9037584))),
                          ),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

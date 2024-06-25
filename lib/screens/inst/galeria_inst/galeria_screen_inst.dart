import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:primerospasosapp/services/crud.dart';
import 'package:primerospasosapp/widgets/headers2.dart';

import '../home_screen_inst.dart';
import 'create_galeria_inst.dart';

class GaleriaScreenInst extends StatefulWidget {
  const GaleriaScreenInst({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GaleriaScreenInst> {
  CrudMethods crudMethods = CrudMethods();

  late Stream blogsStream = const Stream.empty();

  // ignore: non_constant_identifier_names
  Widget BlogsList() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: blogsStream,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BlogsTile(
                    authorName: snapshot.data!.docs[index].get('authorName'),
                    title: snapshot.data!.docs[index].get("title"),
                    description: snapshot.data!.docs[index].get('desc'),
                    imgUrl: snapshot.data!.docs[index].get('imgUrl'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 220),
            child: BlogsList(),
          ),
          const _Encabezado2()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xA9037584),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateGaleriaInst()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ignore: must_be_immutable
class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;
  BlogsTile(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.description,
      required this.authorName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImageDialog(context, imgUrl);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color.fromARGB(143, 0, 0, 0),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    authorName,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showImageDialog(BuildContext context, String imgUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: NetworkImage(imgUrl),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(212, 3, 117, 132),
                            title: const Center(
                                child: Text(
                              "Eliminar Imagen",
                              style: TextStyle(color: Colors.white),
                            )),
                            content: const Text(
                              "¿Estás seguro de que quieres eliminar esta imagen?",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Cierra el AlertDialog
                                },
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  CrudMethods().deleteImageFromStorageAndFirestore(
                                      imgUrl); // Llama al método para eliminar la imagen
                                  Navigator.of(context)
                                      .pop(); // Cierra el AlertDialog
                                  Navigator.of(context)
                                      .pop(); // Cierra el Dialog que muestra la imagen
                                },
                                child: const Text(
                                  "Eliminar",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(212, 3, 117, 132),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _Encabezado2 extends StatelessWidget {
  const _Encabezado2();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const IconHeader2(
          icon: Icons.add_a_photo_rounded,
          titulo: 'Galeria',
        ),
        Positioned(
          left: 10,
          top: 50,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreenInst()));
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:primerospasosapp/screens/repr/home_screen_repr.dart';
import 'package:primerospasosapp/services/crud.dart';
import 'package:primerospasosapp/widgets/headers2.dart';

class GaleriaScreenRepr extends StatefulWidget {
  const GaleriaScreenRepr({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GaleriaScreenRepr> {
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
                      builder: (context) => const HomeScreenRepr()));
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:primerospasosapp/screens/inst/screen_inst.dart';

import '../../../widgets/widgets.dart';
import 'coment_screen_inst.dart';

class ListaScreenInst extends StatefulWidget {
  const ListaScreenInst({super.key});

  @override
  State<ListaScreenInst> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListaScreenInst> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  // Usar DateFormat para formatear fechas
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final CollectionReference _lists =
      FirebaseFirestore.instance.collection('lists');

  String searchText = '';
  String currentDate = '';
  DocumentReference? _currentDayDoc;

  @override
  void initState() {
    super.initState();
    currentDate =
        _dateFormat.format(DateTime.now()); // Inicializar currentDate aquí
    _initializeCurrentDay();
  }

  Future<void> _initializeCurrentDay() async {
    QuerySnapshot snapshot =
        await _lists.where('date', isEqualTo: currentDate).get();
    if (snapshot.docs.isEmpty) {
      // No existe documento para la fecha seleccionada, crear uno nuevo
      DocumentReference newDoc = await _lists.add({
        'date': currentDate,
        'items': [],
      });
      setState(() {
        _currentDayDoc = newDoc;
      });
    } else {
      // Existe documento para la fecha seleccionada
      setState(() {
        _currentDayDoc = snapshot.docs.first.reference;
      });
    }
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Alumno",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(169, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xA9037584))),
                  labelText: 'Nombre y Apellido:',
                  hintText: '',
                ),
              ),
              TextField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Salon',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xA9037584))),
                  hintText: '',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final String name = _nameController.text;
                    final int? number = int.tryParse(_numberController.text);
                    if (number != null && _currentDayDoc != null) {
                      // Generar un ID único para el nuevo elemento
                      String itemId = _currentDayDoc!.id;

                      // Obtener la lista actual de ítems desde Firestore
                      List<dynamic> items =
                          (await _currentDayDoc!.get()).get('items');

                      // Añadir el nuevo ítem a la lista con el campo 'coment'
                      items.add({
                        "id": itemId,
                        "name": name,
                        "number": number,
                        "selected": false,
                        "coment":
                            "", // Campo 'coment' inicializado como cadena vacía
                      });

                      await _currentDayDoc!.update({
                        "items": items,
                      });

                      _nameController.text = '';
                      _numberController.text = '';

                      // Cerrar el modal
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Agregar",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(169, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _update(
      [DocumentSnapshot? documentSnapshot, Map<String, dynamic>? item]) async {
    if (item != null) {
      _nameController.text = item['name'];
      _numberController.text = item['number'].toString();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Editar",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(169, 0, 0, 0)),
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre y Apellido:',
                  hintText: '',
                ),
              ),
              TextField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Salon:',
                  hintText: '',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = _nameController.text;
                  final int? number = int.tryParse(_numberController.text);
                  if (number != null &&
                      _currentDayDoc != null &&
                      item != null) {
                    List items =
                        List.from((await _currentDayDoc!.get()).get('items'));
                    int index = items.indexWhere((element) =>
                        element['name'] == item['name'] &&
                        element['number'] == item['number']);
                    if (index != -1) {
                      items[index] = {
                        "name": name,
                        "number": number,
                        "selected": item["selected"],
                        "coment":
                            item["coment"], // Mantener el comentario existente
                      };
                      await _currentDayDoc!.update({"items": items});
                      _nameController.text = '';
                      _numberController.text = '';

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();

                      // Navegar a la pantalla de agregar comentario
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComentScreenInst(
                            onSaveComment: (String comment) async {
                              items[index]['coment'] = comment;
                              await _currentDayDoc!.update({"items": items});
                            },
                            savedComments: const [],
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Center(
                  child: Text(
                    "Actualizar",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(169, 0, 0, 0)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete(Map<String, dynamic> item) async {
    if (_currentDayDoc != null) {
      // Obtener la lista actual de ítems desde Firestore
      List<dynamic> items = (await _currentDayDoc!.get()).get('items');

      // Eliminar el elemento específico de la lista local
      items.removeWhere((element) =>
          element['name'] == item['name'] &&
          element['number'] == item['number']);

      await _currentDayDoc!.update({
        "items": items,
      });

      _nameController.text = '';
      _numberController.text = '';

      setState(() {});

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color(0xA9037584),
        content: Center(child: Text("Elemento eliminado")),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            margin: const EdgeInsets.only(top: 170),
            child: StreamBuilder<DocumentSnapshot>(
              stream: _currentDayDoc?.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  List items = snapshot.data!.get('items');
                  List filteredItems = items
                      .where((item) => item['name']
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      bool isSelected = item['selected'] ?? false;
                      return Card(
                        color: const Color(0xA1218C9A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            value: isSelected,
                            onChanged: (bool? value) async {
                              setState(() {
                                isSelected = value ?? false;
                              });
                              item['selected'] = isSelected;
                              await _currentDayDoc!.update({
                                "items": items,
                              });
                            },
                          ),
                          title: Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          subtitle: Text(
                            item['number'].toString(),
                          ),
                          trailing: SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.note_add_rounded,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ComentScreenInst(
                                          onSaveComment:
                                              (String comment) async {
                                            items[index]['coment'] = comment;
                                            await _currentDayDoc!
                                                .update({"items": items});
                                          },
                                          savedComments: const [],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  iconSize: 18,
                                  color: Colors.black,
                                  onPressed: () => _update(snapshot.data, item),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  iconSize: 18,
                                  color: Colors.black,
                                  onPressed: () => _delete(item),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _create(),
            backgroundColor: const Color(0xA9037584),
            child: const Icon(
              Icons.add,
              size: 35,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        _Encabezado2(date: currentDate),
      ],
    );
  }
}

class _Encabezado2 extends StatelessWidget {
  final String date;
  const _Encabezado2({required this.date});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const IconHeader2(
          icon: Icons.list_alt_rounded,
          titulo: 'Lista',
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
              size: 35,
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 160,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _changeDate(context, -1); // Cambia a la fecha anterior
                },
                icon: const Icon(
                  Icons.chevron_left,
                  size: 25,
                ),
                color: Colors.greenAccent,
              ),
              Text(
                date,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 10,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              IconButton(
                onPressed: () {
                  _changeDate(context, 1); // Cambia a la fecha siguiente
                },
                icon: const Icon(
                  Icons.chevron_right,
                  size: 25,
                ),
                color: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _changeDate(BuildContext context, int days) {
    _MyWidgetState state = context.findAncestorStateOfType<_MyWidgetState>()!;
    DateTime currentDate = DateTime.parse(state.currentDate);
    DateTime newDate = currentDate.add(Duration(days: days));
    String newFormattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    // ignore: invalid_use_of_protected_member
    state.setState(() {
      state.currentDate = newFormattedDate;
      state._initializeCurrentDay();
    });
  }
}

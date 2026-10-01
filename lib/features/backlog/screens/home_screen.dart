import 'package:flutter/material.dart';
import 'package:backlog_tracker/features/backlog/models/item.dart';
import 'package:backlog_tracker/features/backlog/widgets/interactive_item_card.dart';

class BacklogHomeScreen extends StatefulWidget {
  const BacklogHomeScreen({super.key});

  @override
  State<BacklogHomeScreen> createState() => _BacklogHomeScreenState();
}

class _BacklogHomeScreenState extends State<BacklogHomeScreen> {
  List<Item> itemList = [
    Item(titulo: "El pianista", categoria: "Pelicula"),
    Item(titulo: "La historia del jazz", categoria: "Libro"),
  ];

  void _mostrarDialogoAgregar() {
    TextEditingController titleController = TextEditingController();
    String categoriaSeleccionada = 'PC';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Agregar elemento"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Título"),
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: categoriaSeleccionada,
                    isExpanded: true,
                    items:
                        <String>[
                          'PC',
                          'Consola',
                          'Móvil',
                          'Libro',
                          'Película',
                        ].map((String valor) {
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(),
                    onChanged: (String? nuevoValor) {
                      setStateDialog(() {
                        categoriaSeleccionada = nuevoValor!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      setState(() {
                        itemList.add(
                          Item(
                            titulo: titleController.text,
                            categoria: categoriaSeleccionada,
                          ),
                        );
                      });
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Elemento agregado"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text("Agregar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text("Backlog Tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            final currentItem = itemList[index];

            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                setState(() {
                  itemList.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${currentItem.titulo} eliminado"),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: InteractiveItemCard(item: currentItem),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAgregar,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

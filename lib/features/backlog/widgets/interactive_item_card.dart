import 'package:flutter/material.dart';
import 'package:backlog_tracker/features/backlog/models/item.dart';
import 'package:backlog_tracker/features/backlog/screens/detail_screen.dart';

class InteractiveItemCard extends StatefulWidget {
  final Item item;

  const InteractiveItemCard({super.key, required this.item});

  @override
  State<InteractiveItemCard> createState() => _InteractiveItemCardState();
}

class _InteractiveItemCardState extends State<InteractiveItemCard> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.item.completado;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCompleted ? Colors.green.shade100 : Colors.white,
      elevation: 4,
      child: ListTile(
        title: Text(
          widget.item.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.item.categoria),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(item: widget.item),
            ),
          );
        },
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isCompleted = !isCompleted;
              widget.item.completado = isCompleted;
            });
          },
          icon: Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:backlog_tracker/features/backlog/models/item.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.completado ? Icons.check_circle : Icons.hourglass_empty,
              size: 80,
              color: item.completado ? Colors.green : Colors.deepOrange,
            ),
            const SizedBox(height: 20),
            Text(
              item.titulo,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Categoría: ${item.categoria}",
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Text(
              item.completado ? "Estado: Completado" : "Estado: Pendiente",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: item.completado ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

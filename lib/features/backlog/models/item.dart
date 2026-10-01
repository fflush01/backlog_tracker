class Item {
  final String titulo;
  final String categoria;
  bool completado;

  Item({
    required this.titulo,
    required this.categoria,
    this.completado = false,
  });
}
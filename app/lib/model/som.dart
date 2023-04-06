// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class Som {
  int? id;
  String som;
  String entrada;
  String? saida;
  List<String> images;
  Som({
    this.id,
    required this.som,
    required this.entrada,
    this.saida,
    required this.images,
  });
}

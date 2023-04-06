// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class Bps {
  int? id;
  String bps;
  String entrada;
  String? saida;
  List<String> images;
  Bps({
    this.id,
    required this.bps,
    required this.entrada,
    this.saida,
    required this.images,
  });
}

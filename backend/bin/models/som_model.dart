// ignore_for_file: public_member_api_docs, sort_constructors_first
class SomModel {
  final int? id;
  final String somnumber;
  final List<String> imagens;
  final DateTime dataPublicacao;
  final DateTime? dataActualizacao;

  SomModel(
    this.id,
    this.somnumber,
    this.imagens,
    this.dataPublicacao,
    this.dataActualizacao,
  );

  factory SomModel.fromjson(Map map) {
    return SomModel(
      map['id'] ?? '',
      map['somnumber'],
      (map['imagens'] as List<dynamic>).cast<String>(),
      DateTime.fromMicrosecondsSinceEpoch(map['dataPublicacao']),
      map['dataActualizacao'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(map['dataActualizacao'])
          : null,
    );
  }

  Map toJson() {
    return {'id': id, 'somnumber': somnumber, 'imagens': imagens};
  }

  @override
  String toString() {
    return 'SomModel(id: $id, somnumber: $somnumber, imagens: $imagens, dataPublicacao: $dataPublicacao, dataActualizacao: $dataActualizacao)';
  }
}

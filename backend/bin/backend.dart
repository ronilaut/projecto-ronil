import 'package:backend/backend.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {

  final handler = await startShelfModular();
  final server = await io.serve(handler, "localhost", 4466);
  print('Servidor iniciado => ${server.address}:${server.port}');
}

import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler();

  Handler createHandler({
    required Handler route,
    List<Middleware>? middlewares,
  }) {
    //Verifica se a variável é nula, caso seja, ele atribuirá uma lista vazia
    middlewares ??= [];

    var pipe = Pipeline();

    middlewares.forEach((m) => pipe = pipe.addMiddleware(m));

    return pipe.addHandler(route);
  }
}

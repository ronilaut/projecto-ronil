import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependecy_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler();

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    final _di = DependencyInjector();

    var _securityService = _di.get<SecurityService>();

    //Verifica se a variável é nula, caso seja, ele atribuirá uma lista vazia
    middlewares ??= [];

    var pipe = Pipeline();

    middlewares.forEach((m) => pipe = pipe.addMiddleware(m));

    return pipe.addHandler(router);
  }
}

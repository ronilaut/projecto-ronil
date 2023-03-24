import 'package:shelf/shelf.dart';

import 'apis/login_api.dart';
import 'apis/som_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/som_service.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  SecurityService _securityService = SecurityServiceImp();

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler())
      .add(SomApi(SomService()).handler)
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(_securityService.authorization)
      .addMiddleware(_securityService.verifyJwt)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      address: 'localhost',
      port: await CustomEnv.get<int>(key: 'server_port'));
}

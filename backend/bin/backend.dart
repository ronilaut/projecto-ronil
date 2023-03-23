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
  
  //SecurityService _security

  var cascadeHandler = Cascade().add(LoginApi(SecurityServiceImp()).handler).add(SomApi(SomService()).handler).handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(SecurityServiceImp().authorization)
      .addMiddleware(SecurityServiceImp().verifyJwt)
      .addHandler(cascadeHandler);

  await  CustomServer().initialize(
      handler: handler,
      address: 'localhost',
      port: await CustomEnv.get<int>(key: 'server_port'));
}

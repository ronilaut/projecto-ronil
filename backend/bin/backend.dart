import 'dart:io';

import 'package:shelf/shelf.dart';

import 'apis/login_api.dart';
import 'apis/som_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependecy_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/som_service.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = DependencyInjector();

  _di.register<SecurityService>(() => SecurityServiceImp(), isSingleton: true);

  var _securityService = _di.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler())
      .add(SomApi(SomService()).getHandler(
        middlewares: [
          //_securityService.authorization,
          //_securityService.verifyJwt,
        ],
      ))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      //.addMiddleware(_securityService.authorization) //Global Middlewares
      //.addMiddleware(_securityService.verifyJwt) //Global Middlewares
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      address: 'localhost',
      port: await CustomEnv.get<int>(key: 'server_port'));
}

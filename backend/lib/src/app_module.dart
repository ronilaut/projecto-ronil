import 'package:backend/src/features/core/services/database/postgres/postgres_database.dart';
import 'package:backend/src/features/core/services/database/remote_database.dart';
import 'package:backend/src/features/core/services/dot_env_service.dart';
import 'package:backend/src/features/som/image/image_resource.dart';
import 'package:backend/src/features/som/som_resource.dart';
import 'package:backend/src/features/user/user_resource.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.instance<DotEnvService>(DotEnvService.instance),
        Bind.singleton<RemoteDatabase>((i) => PostgresDatabase(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get("/", (Request request) {
          return Response.ok("Inicial Body");
        }),
        Route.resource(UserResource()),
        Route.resource(SomResource()),
        Route.resource(ImageResource()),
      ];
}

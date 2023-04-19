import 'dart:async';
import 'dart:convert';

import 'package:backend/src/features/core/services/database/remote_database.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        //?create
        Route.post("/users", _createUser),
        //?read
        Route.get("/users", _getAllUsers),
        Route.get("/users/:id", _getUserById),
        Route.get("/users/user/:name", _getUserByName),
        //?update
        Route.put("/users", _updateUser),
        //?delete
        Route.delete("/users/:id", _deleteUser)
      ];

  //!Start Create User
  FutureOr<Response> _createUser(
      ModularArguments arguments, Injector injector) async {
    final user = (arguments.data as Map).cast<String, dynamic>();
    user.remove('id');

    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
        'INSERT INTO "User" (name, email, password) VALUES (@name, @email, @password) RETURNING id, name, email, role;',
        variables: user);
    final userMap = result.map((element) => element['User']).first;
    return Response.ok(jsonEncode(userMap));
  }
  //*End Create User

  //! Start Get/Read Users
  FutureOr<Response> _getAllUsers(Injector injector) async {
    final database = injector.get<RemoteDatabase>();

    final result = await database.query('select * from "User";');
    final listUser = result.map((element) => element['User']).toList();
    return Response.ok(jsonEncode(listUser));
  }

  FutureOr<Response> _getUserById(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final database = injector.get<RemoteDatabase>();

    final result = await database.query(
      'SELECT * FROM "User" WHERE id = @id;',
      variables: {
        'id': id,
      },
    );
    final userMap = result.map((element) => element['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  FutureOr<Response> _getUserByName(
      ModularArguments arguments, Injector injector) async {
    final name = arguments.params['name'];
    final database = injector.get<RemoteDatabase>();

    final result = await database.query(
      'SELECT * FROM "User" WHERE id = @name;',
      variables: {
        'name': name,
      },
    );
    final userMap = result.map((element) => element['User']).first;

    return Response.ok(jsonEncode(userMap));
  }
  //*End Get/Read Users

  //!Start Update User
  FutureOr<Response> _updateUser(ModularArguments arguments) {
    return Response.ok("Usuario ${arguments.data} actualizado");
  }
  //*End Update User

  //!Start Delete User
  FutureOr<Response> _deleteUser(
      ModularArguments arguments, Injector injector) async {
    final id = arguments.params['id'];
    final database = injector.get<RemoteDatabase>();
    await database
        .query('DELETE FROM "User" WHERE id @id;', variables: {'id': id});
    return Response.ok("Usuario $id Eliminado");
  }
  //*End Delete User
}

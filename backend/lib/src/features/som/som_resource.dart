import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:backend/src/features/core/services/database/remote_database.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class SomResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get("/soms", _getAllSoms),
        Route.post("/soms", _createSom),
      ];

  //!Start Create User
  FutureOr<Response> _createSom(
      ModularArguments arguments, Injector injector) async {
    print(arguments.data);
    final som = (arguments.data as Map).cast<String, dynamic>();
    som.remove('id');
    print(som);

    final database = injector.get<RemoteDatabase>();
    final result = await database.query(
        'INSERT INTO "Som" (som, created_at) VALUES (@som, @created_at) RETURNING id, som;',
        variables: som);
    final somMap = result.map((element) => element['Som']).first;

    return Response.ok(jsonEncode(somMap));
  }
  //*End Create User

  //! Start Get/Read Users
  FutureOr<Response> _getAllSoms(Injector injector) async {
    // Get the current directory
    Directory currentDirectory = Directory.current;

    // Get a specific subdirectory within the current directory
    String subdirectoryName =
        'public/uploads/SOM'; // Replace with the name of the subdirectory you want to access
    Directory subdirectory =
        Directory('${currentDirectory.path}/$subdirectoryName');
    print(subdirectory);

    // Check if the subdirectory exists
    if (subdirectory.existsSync()) {
      print('Found the subdirectory at path: ${subdirectory.path}');
      var myFie = File('${subdirectory.path}/file.txt');
      await myFie.writeAsString("Hello World");
      print(myFie.toString());

      // Perform operations on the subdirectory
      // ...
    } else {
      print('Subdirectory not found at path: ${subdirectory.path}');
    }

    // String directoryPath =
    //     '/public/'; // Replace with the absolute path of the directory you want to access

    // // Create a Directory object with the absolute path
    // Directory directory = Directory(directoryPath);

    // // Check if the directory exists
    // if (directory.existsSync()) {
    //   print('Found the directory at path: ${directory.path}');

    //   // Perform operations on the directory
    //   // ...
    // } else {
    //   print('Directory not found at path: ${directory.path}');
    // }

    //final database = injector.get<RemoteDatabase>();

    //final result = await database.query('select * from "User";');
    //final listUser = result.map((element) => element['User']).toList();
    //return Response.ok(jsonEncode(listUser));

    return Response.ok('Ok');
  }

  FutureOr<Response> _getSomById(
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

  FutureOr<Response> _getSomByName(
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
}

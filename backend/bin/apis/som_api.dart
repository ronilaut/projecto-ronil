import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/Som_model.dart';
import '../services/generic_service.dart';
import '../services/som_service.dart';
import 'api.dart';

class SomApi extends Api {
  final GenericService<SomModel> _service;

  SomApi(this._service);
  
  @override
  Handler getHandler({List<Middleware>? middlewares}) {
  Router router = Router();

    //Create
    router.post('/soms', (Request request) async {
      var body = await request.readAsString();
      _service.save(SomModel.fromjson(jsonDecode(body)));
      return Response(201);
    });

    //Read All
    router.get('/soms', (Request request) {
      List<SomModel> soms = _service.findAll();
      List<Map> somMap = soms.map((element) => element.toJson()).toList();
      return Response.ok(jsonEncode(somMap));
    });

    // /soms?id=1 Read By ID
    router.get('/soms', (Request request) {
      // _service.findOne(id);
      String? id = request.url.queryParameters['id'];
      return Response.ok('Carregado um com sucesso');
    });

    //   /soms?id=1   // Update
    router.put('/soms', (Request request) {
      //_service.save(value);
      String? id = request.url.queryParameters['id'];
      return Response.ok('Actualizado um com sucesso');
    });

    //Delete
    router.delete('/soms', (Request request) {
      // _service.delete(value);
      String? id = request.url.queryParameters['id'];
      return Response.ok('Eliminado um com sucesso');
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}

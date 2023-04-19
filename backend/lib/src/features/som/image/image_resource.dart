import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf_multipart/form_data.dart';
import 'package:shelf_multipart/multipart.dart';

class ImageResource extends Resource {
  @override
  List<Route> get routes => [Route.post("/upload", _createImage)];

  //!Start Create Image
  FutureOr<Response> _createImage(
    Request request,
    Injector injector,
  ) async {
    if (!request.isMultipart) {
      return Response.ok('Not a multipart request');
    } else if (request.isMultipartForm) {
      List<String> diretories = [];

      
      
      await for (final formData in request.multipartFormData) {
        String baseUrl = 'http://localhost:4466/';
        
        var name = formData.filename;
        var files = await formData.part.readBytes();
        
        Directory dir = Directory.current;
        String destination = "${dir.path}/public/$name";
        String imagePath = destination;
        Uri imageUrl = Uri.parse(baseUrl + imagePath);
        String imageUrlString = imageUrl.toString();
        print('Image URL: $imageUrlString');
        

        File file = File(destination);
        file.writeAsBytes(files);
        diretories.add (destination);
      }
      return Response.ok(jsonEncode(diretories));
      //return Response.ok(description.toString());
    }

    return Response.ok("Ok");
  }
  //*End Create Image
}

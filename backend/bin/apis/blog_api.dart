import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  Handler get handler {
    Router router = Router();
    return router;
  }
}

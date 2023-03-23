import '../models/Som_model.dart';
import '../utils/list_extension.dart';
import 'generic_service.dart';

class SomService implements GenericService<SomModel> {
  final List<SomModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  List<SomModel> findAll() {
    return _fakeDB;
  }

  @override
  SomModel findOne(int id) {
    return _fakeDB.firstWhere((element) => element.id == id);
  }

  @override
  bool save(SomModel value) {
    SomModel? model = _fakeDB.firstWhereOrNull(
      (element) => element.id == value.id,
    );

    if (model == null) {
      _fakeDB.add(value);
    } else {
      var index = _fakeDB.indexOf(model);
      _fakeDB[index] = value;
    }
    return true;
  }
}

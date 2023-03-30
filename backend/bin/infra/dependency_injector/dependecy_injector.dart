typedef T InstanceCreator<T>();

class DependencyInjector {
  DependencyInjector._();
  static final _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;

  final _instanceMap = Map<Type, _InstanceGenerator<Object>>();

  //Register Instance
  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = false,
  }) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

  //Get Instance
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.geInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> Instance ${T.toString()} not found');
  }
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;
  final InstanceCreator<T> _instanceCreator;

  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? geInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance != null ? _instance : _instanceCreator();
  }
}

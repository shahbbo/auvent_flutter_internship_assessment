import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper<T> {
  final String boxName;
  final Box<T> _box;

  // private constructor
  HiveHelper._(this.boxName, this._box);

  static final Map<String, HiveHelper> _instances = {};

  static Future<HiveHelper<T>> init<T>(
    String boxName, {
    required TypeAdapter<T> adapter,
  }) async {
    if (_instances.containsKey(boxName)) {
      return _instances[boxName] as HiveHelper<T>;
    }

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }

    final box = await Hive.openBox<T>(boxName);

    final instance = HiveHelper._(boxName, box);
    _instances[boxName] = instance;

    return instance;
  }

  /// Get all values
  List<T> getAll() => _box.values.toList();

  /// Add a value with a specific key
  Future<void> add(String key, T value) async => await _box.put(key, value);

  /// Add a value with an auto-generated key
  Future<void> addAutoKey(T value) async => await _box.add(value);

  /// Get a value by its key
  T? get(String key) => _box.get(key);

  /// Get a value by its index
  T? getByIndex(int index) => _box.getAt(index);

  /// Get the length of the box
  int get length => _box.length;

  /// Delete a value by its key
  Future<void> delete(String key) async => await _box.delete(key);

  /// Delete a value by its index
  Future<void> deleteByIndex(int index) async => await _box.deleteAt(index);

  /// Clear the entire box
  Future<void> clear() async => await _box.clear();

  /// Close the box
  Future<void> close() async => await _box.close();

  /// Check if the box contains a specific key
  bool containsKey(String key) => _box.containsKey(key);
}

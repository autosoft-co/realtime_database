export 'realtime_database_unsupported.dart'
    if (dart.library.html) 'realtime_database_web_impl.dart'
    if (dart.library.io) 'realtime_database_native_impl.dart';

abstract class RealtimeDatabase {
  final String Function() _makePrefix;

  RealtimeDatabase(this._makePrefix);

  Future<void> pushValueAtPath(
    String path,
    dynamic value, {
    usePrefix = true,
  });

  Future<void> setValueAtPath(
    String path,
    dynamic value, {
    usePrefix = true,
  });
  Future<void> updateValueAtPath(
    String path,
    dynamic value, {
    usePrefix = true,
  });
  Future<dynamic> getValueAtPath(
    String path, {
    String orderByChild,
    startAt,
    endAt,
    usePrefix = true,
  });
  Stream<dynamic> watchValueAtPath(
    String path, {
    String orderByChild,
    startAt,
    endAt,
    usePrefix = true,
  });

  String getPrefix(bool usePrefix) => usePrefix ? _makePrefix() : '/';
}

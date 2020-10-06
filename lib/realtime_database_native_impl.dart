import 'package:firebase_database/firebase_database.dart';

import 'realtime_database.dart';

class RealtimeDatabaseNativeImpl extends RealtimeDatabase {
  final _database = FirebaseDatabase.instance;

  RealtimeDatabaseNativeImpl(String Function() makePrefix) : super(makePrefix);

  @override
  Future getValueAtPath(String path,
      {String orderByChild, dynamic startAt, endAt, usePrefix = true}) async {
    Query ref = _database.reference().child(getPrefix(usePrefix)).child(path);
    if (orderByChild != null) {
      ref = ref.orderByChild(orderByChild);
    }
    if (startAt != null) {
      ref = ref.startAt(startAt);
    }
    if (endAt != null) {
      ref = ref.endAt(endAt);
    }
    final snap = await ref.once();
    return snap.value;
  }

  @override
  Future<void> setValueAtPath(String path, value, {usePrefix = true}) async {
    await _database
        .reference()
        .child(getPrefix(usePrefix))
        .child(path)
        .set(value);
  }

  @override
  Future<void> updateValueAtPath(String path, value, {usePrefix = true}) async {
    await _database
        .reference()
        .child(getPrefix(usePrefix))
        .child(path)
        .update(value);
  }

  @override
  Stream watchValueAtPath(String path,
      {String orderByChild, startAt, endAt, usePrefix = true}) {
    Query ref = _database.reference().child(getPrefix(usePrefix)).child(path);
    if (orderByChild != null) {
      ref = ref.orderByChild(orderByChild);
    }
    if (startAt != null) {
      ref = ref.startAt(startAt);
    }
    if (endAt != null) {
      ref = ref.endAt(endAt);
    }
    return ref.onValue.map((event) => event.snapshot.value);
  }

  @override
  Future<void> pushValueAtPath(String path, value, {usePrefix = true}) async {
    await _database
        .reference()
        .child(getPrefix(usePrefix))
        .child(path)
        .push()
        .set(value);
  }
}

RealtimeDatabase constructRealtimeDatabase(String Function() makePrefix) {
  return RealtimeDatabaseNativeImpl(makePrefix);
}

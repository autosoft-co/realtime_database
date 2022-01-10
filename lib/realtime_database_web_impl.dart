import 'package:firebase/firebase.dart';

import 'realtime_database.dart';

class RealtimeDatabaseWebImpl extends RealtimeDatabase {
  final _database = database();

  RealtimeDatabaseWebImpl(String Function() makePrefix) : super(makePrefix);

  @override
  Future<void> setValueAtPath(String path, value, {usePrefix = true}) async {
    await _database.ref(getPrefix(usePrefix)).child(path).set(value);
  }

  @override
  Future<void> updateValueAtPath(String path, value, {usePrefix = true}) async {
    await _database.ref(getPrefix(usePrefix)).child(path).update(value);
  }

  @override
  Future getValueAtPath(
    String path, {
    String? orderByChild,
    startAt,
    endAt,
    usePrefix = true,
  }) async {
    Query ref = _database.ref(getPrefix(usePrefix)).child(path);
    if (orderByChild != null) {
      ref = ref.orderByChild(orderByChild);
    }
    if (startAt != null) {
      ref = ref.startAt(startAt);
    }
    if (endAt != null) {
      ref = ref.endAt(endAt);
    }
    final event = await ref.once("value");
    return event.snapshot.val();
  }

  @override
  Stream watchValueAtPath(
    String path, {
    String? orderByChild,
    startAt,
    endAt,
    usePrefix = true,
  }) {
    Query ref = _database.ref(getPrefix(usePrefix)).child(path);
    if (orderByChild != null) {
      ref = ref.orderByChild(orderByChild);
    }
    if (startAt != null) {
      ref = ref.startAt(startAt);
    }
    if (endAt != null) {
      ref = ref.endAt(endAt);
    }
    return ref.onValue.map((event) => event.snapshot.val());
  }

  @override
  Future<void> pushValueAtPath(String path, value, {usePrefix = true}) async {
    await _database.ref(getPrefix(usePrefix)).child(path).push().set(value);
  }

  @override
  Future<int> get serverTimestamp async {
    final event = await _database.ref("/.info/serverTimeOffset").once("value");
    return (event.snapshot.val() as int) +
        DateTime.now().millisecondsSinceEpoch;
  }
}

RealtimeDatabase constructRealtimeDatabase(String Function() makePrefix) {
  return RealtimeDatabaseWebImpl(makePrefix);
}

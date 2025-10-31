//
//
// abstract class CacheHelper {
//   Future get(String key);
//
//   Future<bool> has(String key);
//
//   Future<bool> put(String key, dynamic value);
//
//   Future<bool> clear(String key);
// }
//
// class CacheImpl extends CacheHelper {
//   @override
//   Future<bool> clear(String key)async {
//     final bool f = await _basicErrorHandling(() async {
//       return (await SharedPreferences.getInstance()).containsKey(key) && ((await SharedPreferences.getInstance())).getString(key)!.isNotEmpty;
//     });
//     return f;
//   }
//
//   @override
//   Future get(String key) {
//     // TODO: implement get
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<bool> has(String key) {
//     // TODO: implement has
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<bool> put(String key, value) {
//     // TODO: implement put
//     throw UnimplementedError();
//   }
// }
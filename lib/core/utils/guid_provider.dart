import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class GuidProvider {
  static String? _guid;

  static Future<String> getGuid() async {
    if (_guid != null) return _guid!;

    final prefs = await SharedPreferences.getInstance();
    var guid = prefs.getString('jarvis_guid');

    if (guid == null || guid.isEmpty) {
      guid = const Uuid().v4();
      await prefs.setString('jarvis_guid', guid);
    }

    _guid = guid;
    return guid!;
  }
}

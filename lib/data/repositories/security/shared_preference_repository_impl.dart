import 'package:github_commit_history/domain/repositories/security/shared_preference_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {
  late SharedPreferences _prefs;

  SharedPreferencesRepositoryImpl() {
    SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}

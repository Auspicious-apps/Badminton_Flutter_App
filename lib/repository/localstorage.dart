import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final GetStorage _box = GetStorage();
  final String _tokenKey = 'auth_token';
  final String _onboardedKey = 'onboarded';

  // Save authentication token
  void saveAuthToken(String token) {
    _box.write(_tokenKey, token);
  }

  // Get authentication token
  String? getAuthToken() {
    return _box.read(_tokenKey);
  }

  // Remove authentication token
  void removeAuthToken() {
    _box.remove(_tokenKey);
  }

  // Save onboarded status
  void saveOnboarded(bool isOnboarded) {
    _box.write(_onboardedKey, isOnboarded);
  }

  // Get onboarded status
  bool? getOnboarded() {
    return _box.read(_onboardedKey);
  }

  // Remove onboarded status
  void removeOnboarded() {
    _box.remove(_onboardedKey);
  }
}
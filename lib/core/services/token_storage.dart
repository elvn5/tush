import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenStorage {
  static const _key = 'auth_token';

  final FlutterSecureStorage _storage;

  TokenStorage()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  Future<void> saveToken(String token) => _storage.write(key: _key, value: token);

  Future<String?> getToken() => _storage.read(key: _key);

  Future<void> deleteToken() => _storage.delete(key: _key);

  Future<bool> hasToken() async => (await _storage.read(key: _key)) != null;
}

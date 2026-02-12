import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';

/// AES-256-GCM encryption with PBKDF2-HMAC-SHA256 key derivation.
///
/// File format: salt(32B) + nonce(12B) + MAC(16B) + ciphertext
class EncryptionService {
  static const int _saltLength = 32;
  static const int _nonceLength = 12;
  static const int _macLength = 16;
  static const int _pbkdf2Iterations = 100000;
  static const int _keyLength = 32; // 256 bits

  final _algorithm = AesGcm.with256bits();

  /// Derives an AES-256 key from a passphrase using PBKDF2.
  Future<SecretKey> _deriveKey(String passphrase, List<int> salt) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: _pbkdf2Iterations,
      bits: _keyLength * 8,
    );
    return pbkdf2.deriveKey(
      secretKey: SecretKey(passphrase.codeUnits),
      nonce: salt,
    );
  }

  /// Encrypts [plainBytes] with [passphrase].
  ///
  /// Returns: salt(32B) + nonce(12B) + MAC(16B) + ciphertext
  Future<Uint8List> encrypt(Uint8List plainBytes, String passphrase) async {
    final salt = SecretKeyData.random(length: _saltLength).bytes;
    final key = await _deriveKey(passphrase, salt);
    final nonce = SecretKeyData.random(length: _nonceLength).bytes;

    final secretBox = await _algorithm.encrypt(
      plainBytes,
      secretKey: key,
      nonce: nonce,
    );

    // Pack: salt + nonce + mac + ciphertext
    final output = BytesBuilder(copy: false);
    output.add(salt);
    output.add(nonce);
    output.add(secretBox.mac.bytes);
    output.add(secretBox.cipherText);
    return output.toBytes();
  }

  /// Decrypts data produced by [encrypt] using [passphrase].
  Future<Uint8List> decrypt(Uint8List encryptedData, String passphrase) async {
    if (encryptedData.length < _saltLength + _nonceLength + _macLength) {
      throw const FormatException('Encrypted data too short');
    }

    int offset = 0;
    final salt = encryptedData.sublist(offset, offset + _saltLength);
    offset += _saltLength;
    final nonce = encryptedData.sublist(offset, offset + _nonceLength);
    offset += _nonceLength;
    final mac = encryptedData.sublist(offset, offset + _macLength);
    offset += _macLength;
    final cipherText = encryptedData.sublist(offset);

    final key = await _deriveKey(passphrase, salt);

    final secretBox = SecretBox(
      cipherText,
      nonce: nonce,
      mac: Mac(mac),
    );

    final decrypted = await _algorithm.decrypt(secretBox, secretKey: key);
    return Uint8List.fromList(decrypted);
  }
}

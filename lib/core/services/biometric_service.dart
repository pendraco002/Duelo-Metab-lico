import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

@singleton
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if biometric authentication is available on the device
  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  /// Get available biometric types (Face ID, Touch ID, Fingerprint, etc.)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  /// Authenticate using biometrics
  Future<BiometricAuthResult> authenticate({
    String reason = 'Confirme sua identidade para acessar o Duelo Metabólico',
    bool useErrorDialogs = true,
    bool stickyAuth = true,
  }) async {
    try {
      // Check if biometric is available
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        return BiometricAuthResult.notAvailable;
      }

      // Perform authentication
      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: reason,
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Autenticação Biométrica',
            cancelButton: 'Cancelar',
            deviceCredentialsRequiredTitle: 'Credenciais do Dispositivo',
            deviceCredentialsSetupDescription: 'Configure a autenticação nas configurações do dispositivo',
            goToSettingsButton: 'Configurações',
            goToSettingsDescription: 'Configure a autenticação biométrica',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancelar',
            goToSettingsButton: 'Configurações',
            goToSettingsDescription: 'Configure a autenticação biométrica',
            lockOut: 'Muitas tentativas. Tente novamente mais tarde.',
          ),
        ],
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          biometricOnly: false,
        ),
      );

      return isAuthenticated 
          ? BiometricAuthResult.success 
          : BiometricAuthResult.failed;
    } catch (e) {
      if (e.toString().contains('UserCancel')) {
        return BiometricAuthResult.cancelled;
      } else if (e.toString().contains('LockedOut')) {
        return BiometricAuthResult.lockedOut;
      } else if (e.toString().contains('NotAvailable')) {
        return BiometricAuthResult.notAvailable;
      } else {
        return BiometricAuthResult.error;
      }
    }
  }

  /// Check if user has enabled biometric for the app
  Future<bool> isBiometricEnabledForApp() async {
    // This would typically check app-specific settings
    // For now, we'll check if biometric is available
    return await isBiometricAvailable();
  }

  /// Get user-friendly biometric type name
  String getBiometricTypeName(BiometricType type) {
    switch (type) {
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.fingerprint:
        return 'Impressão Digital';
      case BiometricType.iris:
        return 'Íris';
      case BiometricType.strong:
        return 'Autenticação Forte';
      case BiometricType.weak:
        return 'Autenticação Básica';
      default:
        return 'Biometria';
    }
  }

  /// Get available biometric types as user-friendly names
  Future<List<String>> getAvailableBiometricNames() async {
    final types = await getAvailableBiometrics();
    return types.map((type) => getBiometricTypeName(type)).toList();
  }
}

enum BiometricAuthResult {
  success,
  failed,
  cancelled,
  notAvailable,
  lockedOut,
  error,
}

extension BiometricAuthResultExtension on BiometricAuthResult {
  bool get isSuccess => this == BiometricAuthResult.success;
  bool get isFailed => this == BiometricAuthResult.failed;
  bool get isCancelled => this == BiometricAuthResult.cancelled;
  bool get isNotAvailable => this == BiometricAuthResult.notAvailable;
  bool get isLockedOut => this == BiometricAuthResult.lockedOut;
  bool get isError => this == BiometricAuthResult.error;

  String get message {
    switch (this) {
      case BiometricAuthResult.success:
        return 'Autenticação realizada com sucesso';
      case BiometricAuthResult.failed:
        return 'Falha na autenticação biométrica';
      case BiometricAuthResult.cancelled:
        return 'Autenticação cancelada pelo usuário';
      case BiometricAuthResult.notAvailable:
        return 'Autenticação biométrica não disponível';
      case BiometricAuthResult.lockedOut:
        return 'Muitas tentativas falharam. Tente novamente mais tarde';
      case BiometricAuthResult.error:
        return 'Erro na autenticação biométrica';
    }
  }
}
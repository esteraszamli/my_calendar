import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      return _getFirebaseAuthMessage(error);
    } else if (error is FirebaseException) {
      return _getFirebaseMessage(error);
    } else if (error is DioException) {
      return _getDioMessage(error);
    } else {
      final errorString = error.toString().toLowerCase();
      if (_isNetworkRelatedError(errorString)) {
        return 'Sprawdź połączenie z internetem';
      }
      return 'Wystąpił nieoczekiwany błąd. Spróbuj ponownie';
    }
  }

  /// Obsługa błędów Firebase Auth
  static String _getFirebaseAuthMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Nieprawidłowy format emaila';
      case 'user-not-found':
        return 'Użytkownik nie istnieje';
      case 'wrong-password':
        return 'Nieprawidłowe hasło';
      case 'invalid-credential':
        return 'Nieprawidłowy email lub hasło';
      case 'email-already-in-use':
        return 'Konto z tym emailem już istnieje';
      case 'weak-password':
        return 'Hasło jest za słabe. Powinno mieć min. 6 znaków';
      case 'network-request-failed':
        return 'Sprawdź połączenie z internetem';
      default:
        final message = error.message?.toLowerCase() ?? '';
        if (_isNetworkRelatedError(message)) {
          return 'Sprawdź połączenie z internetem';
        }
        return 'Wystąpił błąd logowania';
    }
  }

  /// Obsługa błędów Firebase (Firestore)
  static String _getFirebaseMessage(FirebaseException error) {
    switch (error.code) {
      case 'network-request-failed':
      case 'unavailable':
        return 'Sprawdź połączenie z internetem';
      case 'permission-denied':
        return 'Brak uprawnień do wykonania operacji';
      case 'unauthenticated':
        return 'Wymagane jest zalogowanie';
      case 'not-found':
        return 'Nie znaleziono danych';
      case 'already-exists':
        return 'Dane już istnieją';
      default:
        final message = error.message?.toLowerCase() ?? '';
        if (_isNetworkRelatedError(message)) {
          return 'Sprawdź połączenie z internetem';
        }
        return 'Wystąpił błąd serwera. Spróbuj ponownie';
    }
  }

  /// Obsługa błędów HTTP (Dio)
  static String _getDioMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Sprawdź połączenie z internetem';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return 'Nieprawidłowe dane';
          case 401:
            return 'Brak autoryzacji';
          case 403:
            return 'Brak uprawnień';
          case 404:
            return 'Nie znaleziono danych';
          case 429:
            return 'Zbyt wiele żądań. Spróbuj za chwilę';
          case 500:
          case 502:
          case 503:
          case 504:
            return 'Problem z serwerem. Spróbuj ponownie';
          default:
            return 'Problem z serwerem. Spróbuj ponownie';
        }
      case DioExceptionType.cancel:
        return 'Operacja została anulowana';
      default:
        final message = error.message?.toLowerCase() ?? '';
        if (_isNetworkRelatedError(message)) {
          return 'Sprawdź połączenie z internetem';
        }
        return 'Wystąpił nieoczekiwany błąd. Spróbuj ponownie';
    }
  }

  /// Sprawdź czy błąd jest związany z siecią
  static bool isNetworkError(dynamic error) {
    if (error is FirebaseAuthException || error is FirebaseException) {
      if (error.code == 'network-request-failed' ||
          error.code == 'unavailable') {
        return true;
      }
      final message = error.message?.toLowerCase() ?? '';
      if (_isNetworkRelatedError(message)) {
        return true;
      }
    } else if (error is DioException) {
      return error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError;
    } else {
      final errorString = error.toString().toLowerCase();
      return _isNetworkRelatedError(errorString);
    }
    return false;
  }

  /// Pomocnicza metoda do rozpoznawania błędów sieciowych w tekście
  static bool _isNetworkRelatedError(String message) {
    return message.contains('network') ||
        message.contains('internet') ||
        message.contains('connection') ||
        message.contains('host') ||
        message.contains('timeout') ||
        message.contains('unreachable') ||
        message.contains('offline') ||
        message.contains('no internet') ||
        message.contains('socketexception') ||
        message.contains('failed to connect') ||
        message.contains('unable to resolve host') ||
        message.contains('firestore.googleapis.com') ||
        message.contains('unavailable') ||
        message.contains('eai_nodata') ||
        message.contains('no address associated with hostname') ||
        message.contains('unknownhostexception') ||
        message.contains('gaierror') ||
        message.contains('stream closed');
  }
}

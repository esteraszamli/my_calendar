import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static AppException handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is FirebaseException) {
      return _handleFirebaseError(error);
    } else if (error is AppException) {
      return error;
    } else {
      return ServerException(
          'Wystąpił nieoczekiwany błąd: ${error.toString()}');
    }
  }

  static AppException _handleDioError(DioException error) {
    switch (error.type) {
      // Te są rzeczywiście związane z połączeniem
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException('Sprawdź połączenie z Internetem');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return const ValidationException('Nieprawidłowe dane');
          case 401:
            return const ValidationException('Brak autoryzacji');
          case 403:
            return const ValidationException('Brak uprawnień');
          case 404:
            return const ServerException('Nie znaleziono zasobu');
          case 429:
            return const ServerException(
                'Zbyt wiele żądań. Spróbuj ponownie za chwilę');
          case 500:
          case 502:
          case 503:
          case 504:
            return const ServerException(
                'Problem z serwerem. Spróbuj ponownie');
          default:
            return ServerException(
                'Błąd serwera (${statusCode ?? 'nieznany'})');
        }

      case DioExceptionType.cancel:
        return const ServerException('Żądanie zostało anulowane');

      case DioExceptionType.unknown:
      default:
        // Sprawdzamy czy to może być problem z internetem
        if (error.message?.toLowerCase().contains('network') == true ||
            error.message?.toLowerCase().contains('connection') == true ||
            error.message?.toLowerCase().contains('host') == true) {
          return const NetworkException('Sprawdź połączenie z Internetem');
        }
        return ServerException(
            'Wystąpił nieoczekiwany błąd: ${error.message ?? 'Nieznany błąd'}');
    }
  }

  static AppException _handleFirebaseError(FirebaseException error) {
    switch (error.code) {
      // Błędy rzeczywiście związane z siecią
      case 'network-request-failed':
      case 'unavailable':
        return const NetworkException('Sprawdź połączenie z Internetem');

      // Błędy autoryzacji
      case 'permission-denied':
        return const ValidationException(
            'Brak uprawnień do wykonania operacji');
      case 'unauthenticated':
        return const ValidationException('Wymagane jest zalogowanie');

      // Błędy danych
      case 'not-found':
        return const ServerException('Nie znaleziono zasobu');
      case 'already-exists':
        return const ValidationException('Zasób już istnieje');
      case 'invalid-argument':
        return const ValidationException('Nieprawidłowe dane');

      // Błędy limitów
      case 'resource-exhausted':
      case 'deadline-exceeded':
        return const ServerException(
            'Serwer jest przeciążony. Spróbuj ponownie');

      // Błędy wewnętrzne
      case 'internal':
      case 'unknown':
        return const ServerException('Problem z serwerem. Spróbuj ponownie');

      default:
        // Nie zakładamy że to problem z internetem
        return ServerException('Błąd Firebase: ${error.message ?? error.code}');
    }
  }
}

abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class ServerException extends AppException {
  const ServerException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class SnackBarManager {
  static void clearAllSnackBars(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    clearAllSnackBars(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    clearAllSnackBars(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

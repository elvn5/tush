import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  // Event names
  static const String _eventDreamCreated = 'dream_created';
  static const String _eventDreamDeleted = 'dream_deleted';
  static const String _eventDreamsViewed = 'dreams_viewed';
  static const String _eventLogin = 'login';
  static const String _eventLogout = 'logout';
  static const String _eventSignUp = 'sign_up';

  // Dream events
  Future<void> trackDreamCreated() async {
    await _analytics.logEvent(
      name: _eventDreamCreated,
      parameters: {'timestamp': DateTime.now().toIso8601String()},
    );
  }

  Future<void> trackDreamDeleted({required String dreamId}) async {
    await _analytics.logEvent(
      name: _eventDreamDeleted,
      parameters: {
        'dream_id': dreamId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> trackDreamsViewed({int? count}) async {
    await _analytics.logEvent(
      name: _eventDreamsViewed,
      parameters: {
        if (count != null) 'dream_count': count,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // Auth events
  Future<void> trackLogin({required String method}) async {
    await _analytics.logEvent(
      name: _eventLogin,
      parameters: {
        'method': method,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> trackLogout() async {
    await _analytics.logEvent(
      name: _eventLogout,
      parameters: {'timestamp': DateTime.now().toIso8601String()},
    );
  }

  Future<void> trackSignUp({required String method}) async {
    await _analytics.logEvent(
      name: _eventSignUp,
      parameters: {
        'method': method,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}

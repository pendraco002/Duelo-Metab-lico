import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_performance/firebase_performance.dart';

@singleton
class PerformanceService {
  final FirebasePerformance _performance = FirebasePerformance.instance;
  final Map<String, Trace> _activeTraces = {};
  final Map<String, Stopwatch> _customMetrics = {};

  /// Initialize performance monitoring
  Future<void> initialize() async {
    if (kDebugMode) {
      await _performance.setPerformanceCollectionEnabled(false);
    } else {
      await _performance.setPerformanceCollectionEnabled(true);
    }
  }

  /// Start a custom trace
  Future<void> startTrace(String traceName) async {
    try {
      if (_activeTraces.containsKey(traceName)) {
        developer.log('Trace $traceName already active', name: 'PerformanceService');
        return;
      }

      final trace = _performance.newTrace(traceName);
      await trace.start();
      _activeTraces[traceName] = trace;
      
      developer.log('Started trace: $traceName', name: 'PerformanceService');
    } catch (e) {
      developer.log('Error starting trace $traceName: $e', name: 'PerformanceService');
    }
  }

  /// Stop a custom trace
  Future<void> stopTrace(String traceName) async {
    try {
      final trace = _activeTraces.remove(traceName);
      if (trace != null) {
        await trace.stop();
        developer.log('Stopped trace: $traceName', name: 'PerformanceService');
      } else {
        developer.log('Trace $traceName not found', name: 'PerformanceService');
      }
    } catch (e) {
      developer.log('Error stopping trace $traceName: $e', name: 'PerformanceService');
    }
  }

  /// Add metric to active trace
  Future<void> setTraceMetric(String traceName, String metricName, int value) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace != null) {
        trace.setMetric(metricName, value);
        developer.log('Set metric $metricName = $value for trace $traceName', name: 'PerformanceService');
      }
    } catch (e) {
      developer.log('Error setting metric for trace $traceName: $e', name: 'PerformanceService');
    }
  }

  /// Increment metric in active trace
  Future<void> incrementTraceMetric(String traceName, String metricName, [int incrementBy = 1]) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace != null) {
        trace.incrementMetric(metricName, incrementBy);
        developer.log('Incremented metric $metricName by $incrementBy for trace $traceName', name: 'PerformanceService');
      }
    } catch (e) {
      developer.log('Error incrementing metric for trace $traceName: $e', name: 'PerformanceService');
    }
  }

  /// Add custom attribute to trace
  Future<void> setTraceAttribute(String traceName, String attributeName, String value) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace != null) {
        trace.putAttribute(attributeName, value);
        developer.log('Set attribute $attributeName = $value for trace $traceName', name: 'PerformanceService');
      }
    } catch (e) {
      developer.log('Error setting attribute for trace $traceName: $e', name: 'PerformanceService');
    }
  }

  /// Create HTTP metric
  HttpMetric createHttpMetric(String url, HttpMethod httpMethod) {
    return _performance.newHttpMetric(url, httpMethod);
  }

  /// Track screen rendering performance
  Future<void> trackScreenPerformance(String screenName, VoidCallback screenBuilder) async {
    final traceName = 'screen_$screenName';
    await startTrace(traceName);
    
    final stopwatch = Stopwatch()..start();
    
    try {
      screenBuilder();
      
      stopwatch.stop();
      await setTraceMetric(traceName, 'render_time_ms', stopwatch.elapsedMilliseconds);
      await setTraceAttribute(traceName, 'screen_name', screenName);
      
    } finally {
      await stopTrace(traceName);
    }
  }

  /// Track animation performance
  Future<void> trackAnimationPerformance(String animationName, Future<void> Function() animation) async {
    final traceName = 'animation_$animationName';
    await startTrace(traceName);
    
    final stopwatch = Stopwatch()..start();
    
    try {
      await animation();
      
      stopwatch.stop();
      await setTraceMetric(traceName, 'duration_ms', stopwatch.elapsedMilliseconds);
      await setTraceAttribute(traceName, 'animation_name', animationName);
      
    } finally {
      await stopTrace(traceName);
    }
  }

  /// Track game performance
  Future<void> trackGamePerformance(String gameMode, Future<void> Function() gameLogic) async {
    final traceName = 'game_$gameMode';
    await startTrace(traceName);
    
    final stopwatch = Stopwatch()..start();
    
    try {
      await gameLogic();
      
      stopwatch.stop();
      await setTraceMetric(traceName, 'game_duration_ms', stopwatch.elapsedMilliseconds);
      await setTraceAttribute(traceName, 'game_mode', gameMode);
      
    } finally {
      await stopTrace(traceName);
    }
  }

  /// Track network request performance
  Future<T> trackNetworkRequest<T>(String endpoint, Future<T> Function() request) async {
    final traceName = 'network_request';
    await startTrace(traceName);
    
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await request();
      
      stopwatch.stop();
      await setTraceMetric(traceName, 'request_time_ms', stopwatch.elapsedMilliseconds);
      await setTraceAttribute(traceName, 'endpoint', endpoint);
      await setTraceAttribute(traceName, 'status', 'success');
      
      return result;
    } catch (e) {
      stopwatch.stop();
      await setTraceMetric(traceName, 'request_time_ms', stopwatch.elapsedMilliseconds);
      await setTraceAttribute(traceName, 'endpoint', endpoint);
      await setTraceAttribute(traceName, 'status', 'error');
      await setTraceAttribute(traceName, 'error', e.toString());
      rethrow;
    } finally {
      await stopTrace(traceName);
    }
  }

  /// Track memory usage
  void trackMemoryUsage(String context) {
    if (kDebugMode) {
      developer.log('Memory usage tracked for: $context', name: 'PerformanceService');
      // In debug mode, you could add more detailed memory tracking
    }
  }

  /// Start custom metric measurement
  void startCustomMetric(String metricName) {
    _customMetrics[metricName] = Stopwatch()..start();
    developer.log('Started custom metric: $metricName', name: 'PerformanceService');
  }

  /// Stop custom metric measurement and return duration
  Duration? stopCustomMetric(String metricName) {
    final stopwatch = _customMetrics.remove(metricName);
    if (stopwatch != null) {
      stopwatch.stop();
      final duration = stopwatch.elapsed;
      developer.log('Stopped custom metric $metricName: ${duration.inMilliseconds}ms', name: 'PerformanceService');
      return duration;
    }
    return null;
  }

  /// Log performance event
  void logPerformanceEvent(String event, Map<String, dynamic> parameters) {
    developer.log(
      'Performance event: $event',
      name: 'PerformanceService',
      error: parameters,
    );
  }

  /// Monitor frame rate
  void startFrameRateMonitoring() {
    if (kDebugMode) {
      // Add frame rate monitoring logic for debug builds
      developer.log('Frame rate monitoring started', name: 'PerformanceService');
    }
  }

  /// Stop frame rate monitoring
  void stopFrameRateMonitoring() {
    if (kDebugMode) {
      developer.log('Frame rate monitoring stopped', name: 'PerformanceService');
    }
  }

  /// Cleanup resources
  Future<void> dispose() async {
    // Stop all active traces
    final traceNames = _activeTraces.keys.toList();
    for (final traceName in traceNames) {
      await stopTrace(traceName);
    }
    
    // Clear all custom metrics
    _customMetrics.clear();
    
    developer.log('Performance service disposed', name: 'PerformanceService');
  }
}

/// Pre-defined trace names for common operations
class PerformanceTraces {
  static const String appStart = 'app_start';
  static const String userLogin = 'user_login';
  static const String gameSession = 'game_session';
  static const String questionLoad = 'question_load';
  static const String answerSubmit = 'answer_submit';
  static const String leaderboardLoad = 'leaderboard_load';
  static const String achievementUnlock = 'achievement_unlock';
  static const String profileLoad = 'profile_load';
  static const String settingsLoad = 'settings_load';
}

/// Pre-defined metric names
class PerformanceMetrics {
  static const String duration = 'duration_ms';
  static const String memoryUsage = 'memory_usage_mb';
  static const String networkLatency = 'network_latency_ms';
  static const String frameDrops = 'frame_drops';
  static const String loadTime = 'load_time_ms';
  static const String responseTime = 'response_time_ms';
}

/// Performance monitoring wrapper
class PerformanceWrapper {
  static Future<T> trackAsync<T>(
    PerformanceService service,
    String traceName,
    Future<T> Function() operation,
  ) async {
    await service.startTrace(traceName);
    try {
      return await operation();
    } finally {
      await service.stopTrace(traceName);
    }
  }

  static T track<T>(
    PerformanceService service,
    String traceName,
    T Function() operation,
  ) {
    service.startTrace(traceName);
    try {
      return operation();
    } finally {
      service.stopTrace(traceName);
    }
  }
}
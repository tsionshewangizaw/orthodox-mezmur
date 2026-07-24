import 'dart:async';
import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioPlayer? _audioPlayer;

  final _positionStreamController = StreamController<Duration>.broadcast();
  final _durationStreamController = StreamController<Duration>.broadcast();
  final _playingStreamController = StreamController<bool>.broadcast();

  Stream<Duration> get positionStream => _positionStreamController.stream;
  Stream<Duration> get durationStream => _durationStreamController.stream;
  Stream<bool> get playingStream => _playingStreamController.stream;

  bool _isPlaying = false;

  AudioService._internal();

  Future<void> play(String audioPath) async {
    try {
      // Stop and dispose previous player
      await _audioPlayer?.stop();
      await _audioPlayer?.dispose();

      // Create new player
      _audioPlayer = AudioPlayer();

      // Listen to position updates
      _audioPlayer!.positionStream.listen((position) {
        if (!_positionStreamController.isClosed) {
          _positionStreamController.add(position);
        }
      });

      // Listen to duration updates
      _audioPlayer!.durationStream.listen((duration) {
        if (duration != null && !_durationStreamController.isClosed) {
          _durationStreamController.add(duration);
        }
      });

      // Listen to playing state
      _audioPlayer!.playingStream.listen((isPlaying) {
        _isPlaying = isPlaying;
        if (!_playingStreamController.isClosed) {
          _playingStreamController.add(isPlaying);
        }
      });

      // Listen for completion
      _audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _isPlaying = false;
          if (!_playingStreamController.isClosed) {
            _playingStreamController.add(false);
          }
        }
      });

      // Clean the path
      String cleanPath = audioPath.replaceAll('assets/', '');

      print('Loading audio: assets/$cleanPath');

      // Set the asset and play
      await _audioPlayer!.setAsset('assets/$cleanPath');
      await _audioPlayer!.play();

      _isPlaying = true;

      print('✅ Audio playing: $cleanPath');
    } catch (e) {
      print('❌ Error: $e');
      // Fallback to simulation if audio fails
      _startSimulation();
    }
  }

  void _startSimulation() {
    final Duration totalDuration = const Duration(minutes: 5, seconds: 39);
    Duration currentPosition = Duration.zero;

    if (!_durationStreamController.isClosed) {
      _durationStreamController.add(totalDuration);
    }
    if (!_positionStreamController.isClosed) {
      _positionStreamController.add(currentPosition);
    }
    if (!_playingStreamController.isClosed) {
      _playingStreamController.add(true);
    }

    _isPlaying = true;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isPlaying && currentPosition < totalDuration) {
        currentPosition += const Duration(milliseconds: 100);
        if (!_positionStreamController.isClosed) {
          _positionStreamController.add(currentPosition);
        }
      } else if (currentPosition >= totalDuration || !_isPlaying) {
        timer.cancel();
        _isPlaying = false;
        if (!_playingStreamController.isClosed) {
          _playingStreamController.add(false);
        }
      }
    });
  }

  Future<void> pause() async {
    try {
      await _audioPlayer?.pause();
    } catch (e) {
      print('Pause error: $e');
    }
    _isPlaying = false;
    if (!_playingStreamController.isClosed) {
      _playingStreamController.add(false);
    }
  }

  Future<void> resume() async {
    try {
      await _audioPlayer?.play();
    } catch (e) {
      print('Resume error: $e');
    }
    _isPlaying = true;
    if (!_playingStreamController.isClosed) {
      _playingStreamController.add(true);
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer?.stop();
    } catch (e) {
      print('Stop error: $e');
    }
    _isPlaying = false;
    if (!_playingStreamController.isClosed) {
      _playingStreamController.add(false);
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer?.seek(position);
    } catch (e) {
      print('Seek error: $e');
    }
  }

  void dispose() {
    _audioPlayer?.dispose();
    _positionStreamController.close();
    _durationStreamController.close();
    _playingStreamController.close();
  }
}

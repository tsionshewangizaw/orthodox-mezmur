import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

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
  bool _isShuffle = false;
  bool _isRepeat = false;
  List<String> _playlist = [];
  int _currentIndex = 0;

  AudioService._internal();

  void setPlaylist(List<String> songs) {
    _playlist = songs;
    _currentIndex = 0;
  }

  void toggleShuffle() {
    _isShuffle = !_isShuffle;
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
  }

  bool get isShuffle => _isShuffle;
  bool get isRepeat => _isRepeat;

  Future<void> playNext() async {
    if (_playlist.isEmpty) return;

    if (_isRepeat) {
      await play(_playlist[_currentIndex]);
      return;
    }

    if (_isShuffle) {
      _currentIndex = Random().nextInt(_playlist.length);
    } else {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    }

    await play(_playlist[_currentIndex]);
  }

  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;

    _currentIndex = (_currentIndex - 1) % _playlist.length;
    if (_currentIndex < 0) _currentIndex = _playlist.length - 1;

    await play(_playlist[_currentIndex]);
  }

  Future<void> play(String audioPath) async {
    try {
      await _audioPlayer?.stop();
      await _audioPlayer?.dispose();

      _audioPlayer = AudioPlayer();

      _audioPlayer!.positionStream.listen((position) {
        if (!_positionStreamController.isClosed) {
          _positionStreamController.add(position);
        }
      });

      _audioPlayer!.durationStream.listen((duration) {
        if (duration != null && !_durationStreamController.isClosed) {
          _durationStreamController.add(duration);
        }
      });

      _audioPlayer!.playingStream.listen((isPlaying) {
        _isPlaying = isPlaying;
        if (!_playingStreamController.isClosed) {
          _playingStreamController.add(isPlaying);
        }
      });

      _audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          playNext();
        }
      });

      String cleanPath = audioPath.replaceAll('assets/', '');
      await _audioPlayer!.setAsset('assets/$cleanPath');
      await _audioPlayer!.play();
      _isPlaying = true;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer?.pause();
    } catch (e) {}
    _isPlaying = false;
    if (!_playingStreamController.isClosed) {
      _playingStreamController.add(false);
    }
  }

  Future<void> resume() async {
    try {
      await _audioPlayer?.play();
    } catch (e) {}
    _isPlaying = true;
    if (!_playingStreamController.isClosed) {
      _playingStreamController.add(true);
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer?.stop();
    } catch (e) {}
    _isPlaying = false;
    if (!_playingStreamController.isClosed) {
      _playingStreamController.add(false);
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer?.seek(position);
    } catch (e) {}
  }

  void dispose() {
    _audioPlayer?.dispose();
    _positionStreamController.close();
    _durationStreamController.close();
    _playingStreamController.close();
  }
}

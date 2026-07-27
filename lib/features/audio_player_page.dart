import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../mezmur_bloc.dart';
import '../mezmur_model.dart';
import '../audio_service.dart';
import '../services/favorites_service.dart';

class AudioPlayerPage extends StatefulWidget {
  final MezmurModel mezmur;

  const AudioPlayerPage({super.key, required this.mezmur});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  final AudioService _audioService = AudioService();

  bool _isPlaying = false;
  bool _isShuffle = false;
  bool _isRepeat = false;
  bool _isDragging = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = const Duration(minutes: 5, seconds: 39);
  bool _showLyrics = true;
  late MezmurModel _currentMezmur;
  List<MezmurModel> _playlist = [];
  int _currentIndex = 0;
  bool _isFav = false;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<bool>? _playingSubscription;

  @override
  void initState() {
    super.initState();
    _currentMezmur = widget.mezmur;
    _playlist = MezmurModel.mockMezmurList;
    _currentIndex = _playlist.indexOf(widget.mezmur);
    _checkFavorite();

    _rotationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(_rotationController);
    _setupAudioListeners();
    _startPlayback();
    _audioService.setPlaylist(_playlist.map((m) => m.audioUrl).toList());
  }

  void _checkFavorite() async {
    final fav = await FavoritesService.isFavorite(_currentMezmur.id);
    if (mounted) setState(() => _isFav = fav);
  }

  void _setupAudioListeners() {
    _positionSubscription = _audioService.positionStream.listen((position) {
      if (mounted && !_isDragging) setState(() => _currentPosition = position);
    });
    _durationSubscription = _audioService.durationStream.listen((duration) {
      if (mounted) setState(() => _totalDuration = duration);
    });
    _playingSubscription = _audioService.playingStream.listen((isPlaying) {
      if (mounted) {
        setState(() => _isPlaying = isPlaying);
        if (isPlaying) {
          _rotationController.repeat();
        } else {
          _rotationController.stop();
        }
      }
    });
  }

  Future<void> _startPlayback() async {
    await _audioService.play(_currentMezmur.audioUrl);
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioService.pause();
    } else {
      _audioService.resume();
    }
  }

  void _playNext() {
    if (_isRepeat) {
      _audioService.play(_currentMezmur.audioUrl);
      return;
    }
    if (_isShuffle) {
      _currentIndex = DateTime.now().millisecondsSinceEpoch % _playlist.length;
    } else {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    }
    setState(() => _currentMezmur = _playlist[_currentIndex]);
    _checkFavorite();
    _audioService.play(_currentMezmur.audioUrl);
  }

  void _playPrevious() {
    _currentIndex = (_currentIndex - 1) % _playlist.length;
    if (_currentIndex < 0) _currentIndex = _playlist.length - 1;
    setState(() => _currentMezmur = _playlist[_currentIndex]);
    _checkFavorite();
    _audioService.play(_currentMezmur.audioUrl);
  }

  void _toggleShuffle() => setState(() => _isShuffle = !_isShuffle);
  void _toggleRepeat() => setState(() => _isRepeat = !_isRepeat);

  void _toggleFavorite() async {
    await FavoritesService.toggleFavorite(_currentMezmur.id);
    _checkFavorite();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playingSubscription?.cancel();
    _audioService.stop();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
                child: _showLyrics ? _buildLyricsView() : _buildAlbumArt()),
            _buildAudioControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _audioService.stop();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => setState(() => _showLyrics = !_showLyrics),
            icon: Icon(_showLyrics ? Icons.album : Icons.lyrics,
                color: Theme.of(context).primaryColor),
          ),
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(_isFav ? Icons.favorite : Icons.favorite_border,
                color: _isFav ? Colors.red : Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7)
                    ]),
                  ),
                  child: const Icon(Icons.music_note,
                      size: 80, color: Colors.black),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Text(_currentMezmur.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(_currentMezmur.artist,
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildLyricsView() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(_currentMezmur.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(_currentMezmur.artist,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          Divider(color: Theme.of(context).primaryColor.withOpacity(0.3)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Text(_currentMezmur.lyrics,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 2.0, fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioControls() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                activeTrackColor: Theme.of(context).primaryColor,
                inactiveTrackColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                thumbColor: Theme.of(context).primaryColor),
            child: Slider(
              value: _totalDuration.inSeconds > 0
                  ? _currentPosition.inSeconds
                      .toDouble()
                      .clamp(0.0, _totalDuration.inSeconds.toDouble())
                  : 0.0,
              max: _totalDuration.inSeconds > 0
                  ? _totalDuration.inSeconds.toDouble()
                  : 1.0,
              onChanged: (value) {
                _isDragging = true;
                setState(
                    () => _currentPosition = Duration(seconds: value.toInt()));
              },
              onChangeEnd: (value) {
                _isDragging = false;
                _audioService.seek(Duration(seconds: value.toInt()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_currentPosition),
                    style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                Text(_formatDuration(_totalDuration),
                    style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: _toggleShuffle,
                  icon: Icon(Icons.shuffle,
                      color: _isShuffle
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      size: 28)),
              IconButton(
                  onPressed: _playPrevious,
                  icon: Icon(Icons.skip_previous,
                      color: Theme.of(context).primaryColor, size: 36)),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7)
                    ])),
                child: IconButton(
                    onPressed: _togglePlayPause,
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black, size: 40)),
              ),
              IconButton(
                  onPressed: _playNext,
                  icon: Icon(Icons.skip_next,
                      color: Theme.of(context).primaryColor, size: 36)),
              IconButton(
                  onPressed: _toggleRepeat,
                  icon: Icon(Icons.repeat,
                      color: _isRepeat
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      size: 28)),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
  }
}

class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext, Widget?) builder;
  const AnimatedBuilder(
      {super.key, required this.animation, required this.builder});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: animation, builder: builder);
  }
}

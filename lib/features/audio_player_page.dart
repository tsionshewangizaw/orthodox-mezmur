import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../mezmur_bloc.dart';
import '../mezmur_model.dart';
import '../widget/app_theme.dart';
import '../audio_service.dart';

class AudioPlayerPage extends StatefulWidget {
  final MezmurModel mezmur;

  const AudioPlayerPage({
    super.key,
    required this.mezmur,
  });

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  final AudioService _audioService = AudioService();

  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = const Duration(minutes: 5, seconds: 39);
  bool _showLyrics = true;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<bool>? _playingSubscription;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(_rotationController);

    _setupAudioListeners();
    _startPlayback();
  }

  void _setupAudioListeners() {
    _positionSubscription = _audioService.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    _durationSubscription = _audioService.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _totalDuration = duration;
        });
      }
    });

    _playingSubscription = _audioService.playingStream.listen((isPlaying) {
      if (mounted) {
        setState(() {
          _isPlaying = isPlaying;
          if (isPlaying) {
            _rotationController.repeat();
          } else {
            _rotationController.stop();
          }
        });
      }
    });
  }

  Future<void> _startPlayback() async {
    await _audioService.play(widget.mezmur.audioUrl);
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioService.pause();
    } else {
      _audioService.resume();
    }
  }

  void _onSeek(double value) {
    final newPosition = Duration(seconds: value.toInt());
    _audioService.seek(newPosition);
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
      backgroundColor: AppTheme.pureBlack,
      body: Container(
        decoration: AppTheme.premiumGradient,
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: _showLyrics ? _buildLyricsView() : _buildAlbumArt(),
              ),
              _buildAudioControls(),
            ],
          ),
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
            icon: const Icon(Icons.arrow_back_ios, color: AppTheme.primaryGold),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                _showLyrics = !_showLyrics;
              });
            },
            icon: Icon(
              _showLyrics ? Icons.album : Icons.lyrics,
              color: AppTheme.primaryGold,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<MezmurBloc>().add(ToggleFavorite(widget.mezmur.id));
            },
            icon: Icon(
              widget.mezmur.isFavorite ? Icons.favorite : Icons.favorite_border,
              color:
                  widget.mezmur.isFavorite ? Colors.red : AppTheme.primaryGold,
            ),
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
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryGold, AppTheme.darkGold],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGold.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.music_note,
                      size: 80, color: Colors.black),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Text(
            widget.mezmur.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.mezmur.artist,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildLyricsView() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.cardBlack,
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  widget.mezmur.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.mezmur.artist,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Divider(color: AppTheme.primaryGold.withOpacity(0.3)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.mezmur.lyrics,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 2.0,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
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
        color: AppTheme.surfaceBlack,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border(
            top: BorderSide(color: AppTheme.primaryGold.withOpacity(0.3))),
      ),
      child: Column(
        children: [
          Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 12),
                  activeTrackColor: AppTheme.primaryGold,
                  inactiveTrackColor: AppTheme.primaryGold.withOpacity(0.2),
                  thumbColor: AppTheme.primaryGold,
                ),
                child: Slider(
                  value: _totalDuration.inSeconds > 0
                      ? _currentPosition.inSeconds.toDouble().clamp(
                            0.0,
                            _totalDuration.inSeconds.toDouble(),
                          )
                      : 0.0,
                  max: _totalDuration.inSeconds > 0
                      ? _totalDuration.inSeconds.toDouble()
                      : 1.0,
                  onChanged: _onSeek,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_currentPosition),
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    Text(
                      _formatDuration(_totalDuration),
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shuffle, color: AppTheme.primaryGold),
                iconSize: 28,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.skip_previous,
                    color: AppTheme.primaryGold),
                iconSize: 36,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryGold, AppTheme.darkGold],
                  ),
                ),
                child: IconButton(
                  onPressed: _togglePlayPause,
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.black,
                  ),
                  iconSize: 40,
                  padding: const EdgeInsets.all(16),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.skip_next, color: AppTheme.primaryGold),
                iconSize: 36,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.repeat, color: AppTheme.primaryGold),
                iconSize: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext, Widget?) builder;

  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: builder,
    );
  }
}

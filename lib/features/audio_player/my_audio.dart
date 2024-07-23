import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../core/util/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class MyAudioPlayer extends StatefulWidget {
  final String url;

  const MyAudioPlayer({
    super.key,
    required this.url,
  });

  @override
  State<MyAudioPlayer> createState() => _MyAudioPlayerState();
}

class _MyAudioPlayerState extends State<MyAudioPlayer> with SingleTickerProviderStateMixin {
  final _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  late final animationController = AnimationController(
    vsync: this,
    value: _isPlaying ? 1 : 0,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void initState() {
    super.initState();
    // * listen to the state
    if (mounted) {
      _audioPlayer.onPlayerStateChanged.listen((state) {
        if (state.index != 1) {
          animationController.reverse();
        }
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      });
      _audioPlayer.onPlayerComplete.listen((event) {
        animationController.reverse();
      });
      //* listen to the duration
      _audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _duration = duration;
        });
      });
      //* listen to the position
      _audioPlayer.onPositionChanged.listen((position) {
        setState(() {
          _position = position;
        });
      });
    }
  }

  // void playAudio(String path) {
  //   if(kIsWeb) {
  //     js.context.callMethod('playAudio', [path]);
  //   } else {
  //     // not on the web so we must use a mobile/desktop library...
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        color: HexColor(mainColor),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              // playAudio(widget.url);
              if (_isPlaying) {
                await _audioPlayer.pause();
                animationController.reverse();
              } else {
                await _audioPlayer.play(
                  UrlSource(widget.url),
                );
                //'https://firebasestorage.googleapis.com/v0/b/helpoo-app-d0a1f.appspot.com/o/sample-1.m4a?alt=media&token=6e5d9113-f820-46bf-9ac1-eed5afc7b4cf'
                animationController.forward();
              }
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  color: whiteColor,
                ),
                child: Center(
                  child: AnimatedIcon(
                    color: HexColor(mainColor),
                    size: 40.0,
                    icon: AnimatedIcons.play_pause,
                    progress: animationController,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Slider(
                  value: _position.inSeconds.toDouble(),
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.3),
                  onChanged: (value) {
                    debugPrintFullText('*************************');
                    debugPrintFullText(value.toString());
                    if (mounted) {
                      setState(() {
                        _audioPlayer.seek(Duration(seconds: value.toInt()));
                      });
                    }
                    if (!_isPlaying) {
                      _audioPlayer.resume();
                      animationController.forward();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _position.toString().split('.').first,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                      ),
                      space30Horizontal(),
                      Text(
                        _duration.toString().split('.').first,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

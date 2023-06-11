import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

enum AudioPlayerState {
  init,
  running,
  stop,
  mute,
}

class AudioPlayerNotifier extends Notifier<AudioPlayerState> {
  late AudioPlayer _player;
  @override
  AudioPlayerState build() {
    _player = AudioPlayer();
    return AudioPlayerState.init;
  }

  void play() async {
    await _player.setAsset("assets/audios/audio.mp3");
    _player.play();
    state = AudioPlayerState.running;
  }

  void pause() async {
    await _player.stop();
    state = AudioPlayerState.stop;
  }

  void mute() {
    _player.setVolume(0);
    state = AudioPlayerState.mute;
  }

  void unMute() {
    _player.setVolume(1);
    state = AudioPlayerState.running;
  }

  void setMusic(String name) async {
    await _player.stop();
    await _player.setAsset("assets/audios/$name.mp3");
    await _player.play();
    state == AudioPlayerState.running;
  }
}

final audioPlayerController =
    NotifierProvider<AudioPlayerNotifier, AudioPlayerState>(
        () => AudioPlayerNotifier());

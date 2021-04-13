import 'dart:async';

abstract class AbstractDriver {
  Future<AbstractDriverResult> browseNext(int level);

  Future<AbstractDriverResult> browsePrevious(int level);

  void play();

  Future<AbstractDriverResult> playNext();

  Future<AbstractDriverResult> playPrevious();

  void seekBackward();

  void seekForward();

  Future<AbstractDriverResult> ping();

  void start();

  void toggle();
}

class AbstractDriverResult {
  final String currentSet;
  final String currentArtist;
  final String currentAlbum;
  final String currentTrack;

  AbstractDriverResult(
    this.currentSet,
    this.currentArtist,
    this.currentAlbum,
    this.currentTrack,
  );
}

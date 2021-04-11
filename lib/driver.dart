import 'dart:async';
import 'dart:io';

import 'package:process_run/shell.dart';

abstract class Driver {
  Future<DriverResult> browseNext(int level);

  Future<DriverResult> browsePrevious(int level);

  void play();

  Future<DriverResult> playNext();

  Future<DriverResult> playPrevious();

  void seekBackward();

  void seekForward();

  Future<DriverResult> ping();

  void start();

  void toggle();
}

class DriverResult {
  final String currentSet;
  final String currentArtist;
  final String currentAlbum;
  final String currentTrack;

  DriverResult(final ProcessResult result)
      : currentSet = result.outLines.elementAt(0),
        currentArtist = result.outLines.elementAt(1),
        currentAlbum = result.outLines.elementAt(2),
        currentTrack = result.outLines.elementAt(3);
}

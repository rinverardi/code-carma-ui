import 'dart:io';

import 'package:carma_ui/driver.dart';
import 'package:process_run/shell.dart';

class ShellDriver extends AbstractDriver {
  @override
  Future<AbstractDriverResult> browseNext(int level) async {
    final result = await Shell().run('carma browse_next $level');

    return ShellDriverResult(result.first);
  }

  @override
  Future<AbstractDriverResult> browsePrevious(int level) async {
    final result = await Shell().run('carma browse_previous $level');

    return ShellDriverResult(result.first);
  }

  @override
  Future<AbstractDriverResult> ping() async {
    final result = await Shell().run('carma ping');

    return ShellDriverResult(result.first);
  }

  @override
  void play() => Shell().run('carma play');

  @override
  Future<AbstractDriverResult> playNext() async {
    final result = await Shell().run('carma play_next 3');

    return ShellDriverResult(result.first);
  }

  @override
  Future<AbstractDriverResult> playPrevious() async {
    final result = await Shell().run('carma play_previous 3');

    return ShellDriverResult(result.first);
  }

  @override
  void seekBackward() => Shell().run('carma seek-backward');

  @override
  void seekForward() => Shell().run('carma seek-forward');

  @override
  void start() => Shell().run('carma start');

  @override
  void toggle() => Shell().run('carma toggle');
}

class ShellDriverResult extends AbstractDriverResult {
  ShellDriverResult(ProcessResult processResult)
      : super(
          processResult.outLines.elementAt(0),
          processResult.outLines.elementAt(1),
          processResult.outLines.elementAt(2),
          processResult.outLines.elementAt(3),
        );
}

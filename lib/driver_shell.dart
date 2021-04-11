import 'package:process_run/shell.dart';
import 'package:carma_ui/driver.dart';

class ShellDriver extends Driver {
  @override
  Future<DriverResult> browseNext(int level) async {
    final result = await Shell().run('carma browse_next $level');

    return DriverResult(result.first);
  }

  @override
  Future<DriverResult> browsePrevious(int level) async {
    final result = await Shell().run('carma browse_previous $level');

    return DriverResult(result.first);
  }

  @override
  Future<DriverResult> ping() async {
    final result = await Shell().run('carma ping');

    return DriverResult(result.first);
  }

  @override
  void play() => Shell().run('carma play');

  @override
  Future<DriverResult> playNext() async {
    final result = await Shell().run('carma play_next 3');

    return DriverResult(result.first);
  }

  @override
  Future<DriverResult> playPrevious() async {
    final result = await Shell().run('carma play_previous 3');

    return DriverResult(result.first);
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

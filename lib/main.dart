import 'dart:async';

import 'package:carma_ui/driver.dart';
import 'package:carma_ui/driver_shell.dart';
import 'package:carma_ui/driver_web.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

final driver = ShellDriver();

void main() => runApp(_App());

class _App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  String _currentSet = "";
  String _currentArtist = "";
  String _currentAlbum = "";
  String _currentTrack = "";

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Carma UI"),
          ),
          backgroundColor: Color.fromARGB(0xff, 0xee, 0xee, 0xee),
          body: Column(
            children: [
              _Picker(0, _currentSet),
              _Picker(1, _currentArtist),
              _Picker(2, _currentAlbum),
              _Picker(3, _currentTrack),
              _Controls(),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
          ),
        ),
      );

  void _applyResult(AbstractDriverResult result) => setState(() {
        _currentSet = result.currentSet;
        _currentArtist = result.currentArtist;
        _currentAlbum = result.currentAlbum;
        _currentTrack = result.currentTrack;
      });

  static void _applyResultVia(
      AbstractDriverResult result, BuildContext context) {
    final state = context.findAncestorStateOfType<_AppState>();

    state?._applyResult(result);
  }

  @override
  void initState() {
    super.initState();

    driver.start();

    WidgetsBinding.instance?.addPostFrameCallback(
        (timeStamp) => setWindowFrame(Rect.fromLTRB(0, 0, 400, 260)));

    Timer.periodic(
      Duration(seconds: 1),
      (timer) async => _applyResult(await driver.ping()),
    );
  }
}

class _ButtonBrowseNext extends StatelessWidget {
  final int level;

  _ButtonBrowseNext(this.level);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.chevron_right),
        onPressed: () async => _AppState._applyResultVia(
          await driver.browseNext(level),
          context,
        ),
      );
}

class _ButtonBrowsePrevious extends StatelessWidget {
  final int level;

  _ButtonBrowsePrevious(this.level);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () async => _AppState._applyResultVia(
          await driver.browsePrevious(level),
          context,
        ),
      );
}

class _ButtonPause extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new IconButton(
        icon: Icon(Icons.pause),
        onPressed: () => driver.toggle(),
      );
}

class _ButtonPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: () => driver.play(),
      );
}

class _ButtonPlayNext extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new IconButton(
      icon: Icon(Icons.skip_next),
      onPressed: () async => _AppState._applyResultVia(
            await driver.playNext(),
            context,
          ));
}

class _ButtonPlayPrevious extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new IconButton(
      icon: Icon(Icons.skip_previous),
      onPressed: () async => _AppState._applyResultVia(
            await driver.playPrevious(),
            context,
          ));
}

class _ButtonSeekBackward extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new IconButton(
        icon: Icon(Icons.fast_rewind),
        onPressed: () => driver.seekBackward(),
      );
}

class _ButtonSeekForward extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new IconButton(
        icon: Icon(Icons.fast_forward),
        onPressed: () => driver.seekForward(),
      );
}

class _Controls extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          _ButtonSeekBackward(),
          _ButtonPlayPrevious(),
          _ButtonPause(),
          _ButtonPlay(),
          _ButtonPlayNext(),
          _ButtonSeekForward(),
        ],
      );
}

class _Picker extends StatefulWidget {
  final int level;
  final String value;

  _Picker(this.level, this.value);

  @override
  State<StatefulWidget> createState() => _PickerState();
}

class _PickerState extends State<_Picker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ButtonBrowsePrevious(widget.level),
        Expanded(
          child: widget.value.length == 0
              ? LinearProgressIndicator()
              : _PickerText(widget.value),
        ),
        _ButtonBrowseNext(widget.level),
      ],
    );
  }
}

class _PickerText extends StatelessWidget {
  final String value;

  _PickerText(this.value);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        child: Padding(
          child: Text(
            value,
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.all(8),
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      );
}

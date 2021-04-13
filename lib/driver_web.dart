import 'dart:convert';

import 'package:carma_ui/driver.dart';
import 'package:http/http.dart';

class WebDriver extends AbstractDriver {
  final WebDriverClient client;

  WebDriver(String baseUrl) : client = WebDriverClient(baseUrl);

  @override
  Future<AbstractDriverResult> browseNext(int level) async {
    final response = await client.doPost("browse_next_$level.x=1");

    return WebDriverResult(response);
  }

  @override
  Future<AbstractDriverResult> browsePrevious(int level) async {
    final response = await client.doPost("browse_previous_$level.x=1");

    return WebDriverResult(response);
  }

  @override
  Future<AbstractDriverResult> ping() async {
    final response = await client.doGet();

    return WebDriverResult(response);
  }

  @override
  void play() async => client.doPost('play.x=0');

  @override
  Future<AbstractDriverResult> playNext() async {
      final response = await client.doPost('play_next.x=0');

      return WebDriverResult(response);
  }

  @override
  Future<AbstractDriverResult> playPrevious() async {
    final response = await client.doPost('play_previous.x=0');

    return WebDriverResult(response);
  }

  @override
  void seekBackward() {}

  @override
  void seekForward() {}

  @override
  void start() {}

  @override
  void toggle() => client.doPost('pause.x=0');
}

class WebDriverClient {
  final String baseUrl;

  WebDriverClient(this.baseUrl);

  Future<Response> doGet() => get(Uri.parse('$baseUrl/audio?script=1'));

  Future<Response> doPost(String body) => post(
        Uri.parse('$baseUrl/audio?script=1'),
        body: body,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );
}

class WebDriverResult extends AbstractDriverResult {
  WebDriverResult._(List<String> responseLines)
      : super(
          responseLines.elementAt(0),
          responseLines.elementAt(1),
          responseLines.elementAt(2),
          responseLines.elementAt(3),
        );

  factory WebDriverResult(Response response) {
    final responseLines = LineSplitter().convert(response.body);

    return WebDriverResult._(responseLines);
  }
}

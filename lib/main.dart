import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';

import 'package:flutter_svg/svg.dart';

const List<String> assetNames = const [
  'assets/w3samples/aa.svg',
  'assets/w3samples/alphachannel.svg',
  'assets/deborah_ufw/new-action-expander.svg',
  'assets/deborah_ufw/new-camera.svg',
  'assets/deborah_ufw/new-gif-button.svg',
  'assets/deborah_ufw/new-gif.svg',
  'assets/deborah_ufw/new-image.svg',
  'assets/deborah_ufw/new-mention.svg',
  'assets/deborah_ufw/new-pause-button.svg',
  'assets/deborah_ufw/new-play-button.svg',
  'assets/deborah_ufw/new-send-circle.svg',
  'assets/deborah_ufw/numeric_25.svg',
  'assets/simple/ellipse.svg',
];
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter SVG Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SvgPainter> _painters = new List<SvgPainter>();

  @override
  void initState() {
    super.initState();
    // loadAsset('assets/deborah_ufw/new-camera.svg').then((xml) {
    //   setState(() {
    //     _svgDoc = xml;
    //   });
    // });
    assetNames.forEach((assetName) {
      loadAsset(assetName).then((xml) {
        setState(() {
          _painters.add(new SvgPainter(xml));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new GridView.extent(
        maxCrossAxisExtent: 150.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _painters.map((painter) {
          return new CustomPaint(
              painter: painter, size: const Size(150.0, 150.0));
        }).toList(),
      ),
    );
  }
}

Future<XmlDocument> loadAsset(String assetName) async {
  final xml = await rootBundle.loadString(assetName);
  return parse(xml);
}

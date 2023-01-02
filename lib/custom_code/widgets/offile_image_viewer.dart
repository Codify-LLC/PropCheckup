// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class OffileImageViewer extends StatefulWidget {
  const OffileImageViewer({
    Key? key,
    this.width,
    this.height,
    this.uploadedFile,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Uint8List? uploadedFile;

  @override
  _OffileImageViewerState createState() => _OffileImageViewerState();
}

class _OffileImageViewerState extends State<OffileImageViewer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      widget.uploadedFile ?? Uint8List(0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}

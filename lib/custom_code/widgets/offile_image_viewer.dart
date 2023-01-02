// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class offlineImageViewer extends StatefulWidget {
  const offlineImageViewer({
    Key? key,
    this.width,
    this.height,
    this.uploadedFile,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Uint8List? uploadedFile;

  @override
  _offlineImageViewerState createState() => _offlineImageViewerState();
}

class _offlineImageViewerState extends State<offlineImageViewer> {
  @override
  void initState() {
    // TODO: implement initState
    if (!FFAppState().uploadedImages.contains(widget.uploadedFile ?? []))
      FFAppState().update(
          () => FFAppState().uploadedImages.add(widget.uploadedFile ?? []));
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

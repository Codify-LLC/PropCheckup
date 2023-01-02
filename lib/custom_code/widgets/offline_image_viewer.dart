// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class OfflineImageViewer extends StatefulWidget {
  const OfflineImageViewer({
    Key? key,
    this.width,
    this.height,
    required this.bytesData,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Uint8List bytesData;

  @override
  _OfflineImageViewerState createState() => _OfflineImageViewerState();
}

class _OfflineImageViewerState extends State<OfflineImageViewer> {
  @override
  void initState() {
    // TODO: implement initState
    if (!FFAppState().uploadedImages.contains(widget.bytesData))
      FFAppState()
          .update(() => FFAppState().uploadedImages.add(widget.bytesData));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      widget.bytesData,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}

// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_editor/image_editor.dart';

class OfflineImageViewer extends StatefulWidget {
  const OfflineImageViewer({
    Key? key,
    this.width,
    this.height,
    this.bytesData,
    required this.jsonBytes,
    this.dateTime,
    this.location,
    required this.galleryImage,
    required this.cameraImage,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Uint8List? bytesData;
  final dynamic? jsonBytes;
  final String? dateTime;
  final String? location;
  final bool galleryImage;
  final bool cameraImage;

  @override
  _OfflineImageViewerState createState() => _OfflineImageViewerState();
}

class _OfflineImageViewerState extends State<OfflineImageViewer> {
  Future<Uint8List?> addText(Uint8List image) async {
    const int size = 120;
    final ImageEditorOption option = ImageEditorOption();
    final AddTextOption textOption = AddTextOption();
    textOption.addText(
      EditorText(
        offset: const Offset(0, 0),
        text: widget.dateTime! + " " + widget.location!,
        fontSizePx: size,
        textColor: const Color(0xFF995555),
      ),
    );
    option.outputFormat = const OutputFormat.png();

    option.addOption(textOption);

    final Uint8List u = image;
    final Uint8List? result = await ImageEditor.editImage(
      image: u,
      imageEditorOption: option,
    );
    print(option.toString());

    if (result == null) {
      return null;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bytesData != null &&
        widget.bytesData!.isNotEmpty &&
        !FFAppState().uploadedImages.contains(widget.bytesData)) {
      if (widget.cameraImage) {
        FFAppState().update(() => addText(widget.bytesData!)
            .then((value) => FFAppState().addToUploadedImages(value)));
      } else {
        FFAppState()
            .update(() => FFAppState().addToUploadedImages(widget.bytesData));
      }
    }
    return Visibility(
      visible: (widget.jsonBytes != null && widget.jsonBytes.isNotEmpty) ||
          (widget.bytesData != null && widget.bytesData!.isNotEmpty),
      child: Image.memory(
        widget.jsonBytes != null
            ? Uint8List.fromList(widget.jsonBytes.cast<int>())
            : widget.bytesData ?? Uint8List(0),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}

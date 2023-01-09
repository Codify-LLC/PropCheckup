// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_gallery_saver/image_gallery_saver.dart';

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
  Future saveImageToGallery(Uint8List? imageData) async {
    // Save the image to the gallery
    if (imageData != null &&
        imageData.isNotEmpty &&
        !FFAppState().uploadedImages.contains(imageData)) {
      if (widget.cameraImage) {
        await ImageGallerySaver.saveImage(imageData);
        FFAppState().update(() => FFAppState().addToUploadedImages(imageData));
      } else {
        await ImageGallerySaver.saveImage(imageData);
        FFAppState().update(() => FFAppState().addToUploadedImages(imageData));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: saveImageToGallery(widget.bytesData),
        builder: (context, snapshot) {
          return Visibility(
            visible:
                (widget.jsonBytes != null && widget.jsonBytes.isNotEmpty) ||
                    (widget.bytesData != null && widget.bytesData!.isNotEmpty),
            child: Image.memory(
              widget.jsonBytes != null
                  ? Uint8List.fromList(widget.jsonBytes.cast<int>())
                  : widget.bytesData ?? Uint8List(0),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
            ),
          );
        });
  }
}

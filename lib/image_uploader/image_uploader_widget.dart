import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ImageUploaderWidget extends StatefulWidget {
  const ImageUploaderWidget({Key? key}) : super(key: key);

  @override
  _ImageUploaderWidgetState createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  bool isMediaUploading1 = false;
  Uint8List uploadedFileBytes1 = Uint8List.fromList([]);

  bool isMediaUploading2 = false;
  Uint8List uploadedFileBytes2 = Uint8List.fromList([]);

  LatLng? currentUserLocationValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: FlutterFlowTheme.of(context).primaryColor,
            ),
          ),
        ),
      );
    }

    return Title(
        title: 'ImageUploader',
        color: FlutterFlowTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            title: Text(
              'Upload Offline Images',
              style: FlutterFlowTheme.of(context).title2,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          body: Align(
            alignment: AlignmentDirectional(0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    child: custom_widgets.OfflineImageViewer(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      bytesData: uploadedFileBytes1,
                      jsonBytes: null,
                      dateTime: getCurrentTimestamp.toString(),
                      location: currentUserLocationValue?.toString(),
                      galleryImage: true,
                      cameraImage: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    child: custom_widgets.OfflineImageViewer(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      bytesData: uploadedFileBytes2,
                      jsonBytes: null,
                      dateTime: getCurrentTimestamp.toString(),
                      location: currentUserLocationValue?.toString(),
                      galleryImage: false,
                      cameraImage: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        // GalleryUpload
                        final selectedMedia = await selectMedia(
                          mediaSource: MediaSource.photoGallery,
                          multiImage: false,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => isMediaUploading1 = true);
                          var selectedMediaBytes = <Uint8List>[];
                          try {
                            selectedMediaBytes =
                                selectedMedia.map((m) => m.bytes).toList();
                          } finally {
                            isMediaUploading1 = false;
                          }
                          if (selectedMediaBytes.length ==
                              selectedMedia.length) {
                            setState(() =>
                                uploadedFileBytes1 = selectedMediaBytes.first);
                          } else {
                            setState(() {});
                            return;
                          }
                        }
                      },
                      text: 'Add From Gallery Offline',
                      options: FFButtonOptions(
                        width: 270,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        // CameraUpload
                        final selectedMedia = await selectMedia(
                          multiImage: false,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => isMediaUploading2 = true);
                          var selectedMediaBytes = <Uint8List>[];
                          try {
                            selectedMediaBytes =
                                selectedMedia.map((m) => m.bytes).toList();
                          } finally {
                            isMediaUploading2 = false;
                          }
                          if (selectedMediaBytes.length ==
                              selectedMedia.length) {
                            setState(() =>
                                uploadedFileBytes2 = selectedMediaBytes.first);
                          } else {
                            setState(() {});
                            return;
                          }
                        }
                      },
                      text: 'Add From Camera Offline',
                      options: FFButtonOptions(
                        width: 270,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  if (FFAppState().uploadedImages.length >= 1)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 24),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed('AllOfflineImages');
                        },
                        text: 'View All Offline Images',
                        options: FFButtonOptions(
                          width: 270,
                          height: 50,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}

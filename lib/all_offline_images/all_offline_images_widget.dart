import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllOfflineImagesWidget extends StatefulWidget {
  const AllOfflineImagesWidget({Key? key}) : super(key: key);

  @override
  _AllOfflineImagesWidgetState createState() => _AllOfflineImagesWidgetState();
}

class _AllOfflineImagesWidgetState extends State<AllOfflineImagesWidget> {
  bool isMediaUploading = false;
  Uint8List uploadedFileBytes = Uint8List.fromList([]);

  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
        title: Text(
          'Offline Images',
          style: FlutterFlowTheme.of(context).subtitle1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Builder(
              builder: (context) {
                final imagebyteData = FFAppState().uploadedImages.toList();
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(imagebyteData.length,
                        (imagebyteDataIndex) {
                      final imagebyteDataItem =
                          imagebyteData[imagebyteDataIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: custom_widgets.OfflineImageViewer(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.5,
                            bytesData: uploadedFileBytes,
                            jsonBytes: imagebyteDataItem,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
            if (false)
              FFButtonWidget(
                onPressed: () async {
                  final selectedMedia = await selectMediaWithSourceBottomSheet(
                    context: context,
                    allowPhoto: true,
                  );
                  if (selectedMedia != null &&
                      selectedMedia.every(
                          (m) => validateFileFormat(m.storagePath, context))) {
                    setState(() => isMediaUploading = true);
                    var selectedMediaBytes = <Uint8List>[];
                    try {
                      selectedMediaBytes =
                          selectedMedia.map((m) => m.bytes).toList();
                    } finally {
                      isMediaUploading = false;
                    }
                    if (selectedMediaBytes.length == selectedMedia.length) {
                      setState(
                          () => uploadedFileBytes = selectedMediaBytes.first);
                    } else {
                      setState(() {});
                      return;
                    }
                  }
                },
                text: 'Button',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

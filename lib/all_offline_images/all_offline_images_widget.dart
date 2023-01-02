import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
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
        child: Builder(
          builder: (context) {
            final imagebyteData = FFAppState().uploadedImages.toList();
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    List.generate(imagebyteData.length, (imagebyteDataIndex) {
                  final imagebyteDataItem = imagebyteData[imagebyteDataIndex];
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: custom_widgets.OfflineImageViewer(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        bytesData: null,
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late SignatureController signatureController1;
  late SignatureController signatureController2;

  @override
  void initState() {
    super.initState();
    signatureController1 = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
    signatureController2 = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    signatureController1.dispose();
    signatureController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Image.network(
                    FFAppState().urlImages,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  ClipRect(
                    child: Signature(
                      controller: signatureController1,
                      backgroundColor: Color(0x00FFFFFF),
                      height: 120,
                    ),
                  ),
                ],
              ),
              Image.network(
                'https://picsum.photos/seed/312/600',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/739/600',
                ),
              ),
              Wrap(
                spacing: 0,
                runSpacing: 0,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [],
              ),
              ClipRect(
                child: Signature(
                  controller: signatureController2,
                  backgroundColor: Colors.white,
                  height: 120,
                ),
              ),
              Image.network(
                'https://picsum.photos/seed/340/600',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Stack(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

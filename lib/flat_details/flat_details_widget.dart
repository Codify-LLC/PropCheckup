import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class FlatDetailsWidget extends StatefulWidget {
  const FlatDetailsWidget({Key? key}) : super(key: key);

  @override
  _FlatDetailsWidgetState createState() => _FlatDetailsWidgetState();
}

class _FlatDetailsWidgetState extends State<FlatDetailsWidget> {
  PagingController<DocumentSnapshot?, DetailsRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  TextEditingController? textController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    textController?.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
        title: Text(
          'Select Flat',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: AlignmentDirectional(0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 0, 4, 0),
                                      child: TextFormField(
                                        controller: textController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: Icon(
                                            Icons.search_sharp,
                                            color: Color(0xFF57636C),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 8, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: 'Search',
                                      options: FFButtonOptions(
                                        width: 100,
                                        height: 40,
                                        color: Color(0xFF4B39EF),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        elevation: 2,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PagedListView<DocumentSnapshot<Object?>?, DetailsRecord>(
                pagingController: () {
                  final Query<Object?> Function(Query<Object?>) queryBuilder =
                      (detailsRecord) => detailsRecord;
                  if (_pagingController != null) {
                    final query = queryBuilder(DetailsRecord.collection);
                    if (query != _pagingQuery) {
                      // The query has changed
                      _pagingQuery = query;
                      _streamSubscriptions.forEach((s) => s?.cancel());
                      _streamSubscriptions.clear();
                      _pagingController!.refresh();
                    }
                    return _pagingController!;
                  }

                  _pagingController = PagingController(firstPageKey: null);
                  _pagingQuery = queryBuilder(DetailsRecord.collection);
                  _pagingController!.addPageRequestListener((nextPageMarker) {
                    queryDetailsRecordPage(
                      queryBuilder: (detailsRecord) => detailsRecord,
                      nextPageMarker: nextPageMarker,
                      pageSize: 10,
                      isStream: true,
                    ).then((page) {
                      _pagingController!.appendPage(
                        page.data,
                        page.nextPageMarker,
                      );
                      final streamSubscription =
                          page.dataStream?.listen((data) {
                        data.forEach((item) {
                          final itemIndexes = _pagingController!.itemList!
                              .asMap()
                              .map((k, v) => MapEntry(v.reference.id, k));
                          final index = itemIndexes[item.reference.id];
                          final items = _pagingController!.itemList!;
                          if (index != null) {
                            items.replaceRange(index, index + 1, [item]);
                            _pagingController!.itemList = {
                              for (var item in items) item.reference: item
                            }.values.toList();
                          }
                        });
                        setState(() {});
                      });
                      _streamSubscriptions.add(streamSubscription);
                    });
                  });
                  return _pagingController!;
                }(),
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                builderDelegate: PagedChildBuilderDelegate<DetailsRecord>(
                  // Customize what your widget looks like when it's loading the first page.
                  firstPageProgressIndicatorBuilder: (_) => Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  itemBuilder: (context, _, listViewIndex) {
                    final listViewDetailsRecord =
                        _pagingController!.itemList![listViewIndex];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x25000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                              child: Container(
                                width: 4,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4B39EF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 16, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listViewDetailsRecord.projectName!,
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF101213),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      listViewDetailsRecord.inspectionID!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      listViewDetailsRecord.unitID!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF4B39EF),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

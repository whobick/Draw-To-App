import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'draw_model.dart';
export 'draw_model.dart';

class DrawWidget extends StatefulWidget {
  const DrawWidget({super.key});

  @override
  _DrawWidgetState createState() => _DrawWidgetState();
}

class _DrawWidgetState extends State<DrawWidget> {
  late DrawModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrawModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.00, 0.00),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                  onPressed: () async {
                    GoRouter.of(context).prepareAuthEvent();
                    await authManager.signOut();
                    GoRouter.of(context).clearRedirectLocation();

                    context.goNamedAuth(
                      'Splash',
                      context.mounted,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                child: Icon(
                  Icons.draw_outlined,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 32.0,
                ),
              ),
              Text(
                'Draw to App',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Inter Tight',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          actions: [
            Align(
              alignment: const AlignmentDirectional(0.00, 0.00),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final signatureImage = await _model.signatureController!
                        .toPngBytes(
                            height: 700,
                            width: (MediaQuery.sizeOf(context).width * 1.0)
                                .round());
                    if (signatureImage == null) {
                      showUploadMessage(
                        context,
                        'Signature is empty.',
                      );
                      return;
                    }
                    showUploadMessage(
                      context,
                      'Uploading signature...',
                      showLoading: true,
                    );
                    final downloadUrl = (await uploadData(
                        getSignatureStoragePath(), signatureImage));

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (downloadUrl != null) {
                      setState(() => _model.uploadedSignatureUrl = downloadUrl);
                      showUploadMessage(
                        context,
                        'Success!',
                      );
                    } else {
                      showUploadMessage(
                        context,
                        'Failed to upload signature.',
                      );
                      return;
                    }

                    _model.apiResultsrl = await VisionAPICall.call(
                      imageUrl: _model.uploadedSignatureUrl,
                      apiKey: FFAppState().apiKey,
                    );
                    if ((_model.apiResultsrl?.succeeded ?? true)) {
                      setState(() {
                        FFAppState().html = VisionAPICall.html(
                          (_model.apiResultsrl?.jsonBody ?? ''),
                        ).toString();
                      });
                      setState(() {
                        _model.signatureController?.clear();
                      });

                      context.pushNamed('Results');
                    }

                    setState(() {});
                  },
                  text: 'BUILD',
                  options: FFButtonOptions(
                    width: 100.0,
                    height: 35.0,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 14.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                    elevation: 0.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ClipRect(
                child: Signature(
                  controller: _model.signatureController ??=
                      SignatureController(
                    penStrokeWidth: 2.0,
                    penColor: FlutterFlowTheme.of(context).primaryText,
                    exportBackgroundColor: Colors.white,
                  ),
                  backgroundColor:
                      FlutterFlowTheme.of(context).primaryBackground,
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 700.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

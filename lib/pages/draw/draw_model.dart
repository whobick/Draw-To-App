import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'draw_widget.dart' show DrawWidget;
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class DrawModel extends FlutterFlowModel<DrawWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Signature widget.
  SignatureController? signatureController;
  String uploadedSignatureUrl = '';
  // Stores action output result for [Backend Call - API (Vision API)] action in Button widget.
  ApiCallResponse? apiResultsrl;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    signatureController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

import 'dart:convert';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'privateAPICall';

class VisionAPICall {
  static Future<ApiCallResponse> call({
    String? imageUrl = '',
    String? apiKey = '',
  }) async {
    final ffApiRequestBody = '''
{
  "model": "gpt-4-vision-preview",
  "messages": [
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "Recreate this image as a working application with html, Tailwind css and javascript within <html> tags. IMPORTANT: Only return the code and nothing else. Start your response with <html> and end it with </html>. Do not include ``` or new lines (\\n) in your response. Always center the html content in the center of the page with a white background."
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "$imageUrl"
          }
        }
      ]
    }
  ],
  "max_tokens": 2000
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Vision API',
      apiUrl: 'https://api.openai.com/v1/chat/completions',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic html(dynamic response) => getJsonField(
        response,
        r'''$.choices[:].message.content''',
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

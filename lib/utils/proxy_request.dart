import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchDataProxy(String url) async {
  String proxyUrl =
  'https://asia-northeast1-digital-innovation-hub-414209.cloudfunctions.net/mag2d-proxy/proxy?url=$url';
  //
  const String username = 'g6330';
    const String password = 'yingweili6330@';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  //
  final response = await http.get(
    Uri.parse(proxyUrl),
    headers: <String, String>{
      'Authorization': basicAuth,
    },
  );
  return response;
}

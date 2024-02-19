import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpProvider {
  String authToken;
  String baseUrl;
  SharedPreferences preferences;

  HttpProvider(this.baseUrl, this.authToken, this.preferences);

  static Future<HttpProvider> fromPassword(String baseUrl, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await HttpProvider.getToken(baseUrl, email, password, prefs);
    HttpProvider provider = HttpProvider(baseUrl, token, prefs);
    return provider;
  }

  static Future<String> getNewToken(String baseUrl, String email, String password) async {
    Uri uri = Uri.parse("$baseUrl/api/Token");
    Object body = {email = email, password = password};
    Response response = await http.post(uri, body: body);
    return response.body;
  }

  Future<String> refreshToken(String accessToken) async {
    
  }

  Future<String> getToken() async {
    String? accessToken = preferences.getString("accessToken");
    if (accessToken != null) {
      if (JwtDecoder.getRemainingTime(accessToken).inMinutes < 5) {
        accessToken = null;
      }
    }
    if (accessToken == null) {
      accessToken = await getNewToken(baseUrl, email, password);
      await prefs.setString("accessToken", accessToken);
    }
    return accessToken;
  }

  Map<String, String> getHeaders() {
    return {'content-type': 'application/json', 'Bearer': authToken!};
  }

  Future<Response> put(String path, Object body) {
    Map<String, String> headers = getHeaders();
    Uri uri = Uri.parse("$baseUrl/$path");
    return http.put(uri, headers: headers, body: body);
  }

  Future<Response> post(String path, Object body) {
    Map<String, String> headers = getHeaders();
    Uri uri = Uri.parse("$baseUrl/$path");
    return http.post(uri, headers: headers, body: body);
  }

  Future<Response> get(String path) {
    Map<String, String> headers = getHeaders();
    Uri uri = Uri.parse("$baseUrl/$path");
    return http.get(uri, headers: headers);
  }
}

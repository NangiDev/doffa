import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:doffa/auth/auth_provider.dart';
import 'package:doffa/auth/fitbit_constants.dart';
import 'package:doffa/auth/withings_constants.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _logger = Logger(printer: SimplePrinter(colors: false));
  static const String _accessTokenKey = "access_token";
  Future<void> signInAsDemo(AuthProvider authProvider) async {
    await authProvider.login("demo_access_token");
    _logger.i("Demo access token saved successfully.");
  }

  Future<void> signInWithFitbit(AuthProvider authProvider) async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: FitbitConstants.getFitbitOAuthUrl(),
        callbackUrlScheme: FitbitConstants.callbackUrlScheme,
      );

      final uri = Uri.parse(result);
      final fragment = uri.fragment;
      final accessToken = _extractAccessToken(fragment);

      if (accessToken != null) {
        await authProvider.login(accessToken);
        _logger.i("Fitbit access token saved successfully.");
      } else {
        _logger.e("Error: Unable to retrieve access token.");
      }
    } catch (e, stacktrace) {
      _logger.e("Authentication failed", error: e, stackTrace: stacktrace);
    }
  }

  Future<void> signInWithWithings(AuthProvider authProvider) async {
    try {
      final response =
          WithingsConstants.isDemoUser
              ? await getDemoResponse()
              : await getFirebaseResponse();

      // Process the response data
      final data = response;
      final accessToken = data['at'];
      final refreshToken = data['rt'];
      final uid = data['uid'].toString();

      // Log the received tokens and user ID
      _logger.i("Access token: $accessToken");
      _logger.i("Refresh token: $refreshToken");
      _logger.i("User ID: $uid");

      // Use the access token to log in the user
      if (accessToken != null) {
        await authProvider.login(
          accessToken,
          refreshToken: refreshToken,
          userId: uid,
        );
        _logger.i("Withings access token saved successfully.");
      } else {
        _logger.e("Error: Unable to retrieve access token.");
      }
    } catch (e, stacktrace) {
      _logger.e("Authentication failed", error: e, stackTrace: stacktrace);
    }
  }

  Future<void> signOut(AuthProvider authProvider) async {
    await authProvider.logout();
    _logger.i("User signed out and token cleared.");
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  String? _extractAccessToken(String fragment) {
    final parameters = fragment.split('&');
    for (var param in parameters) {
      final parts = param.split('=');
      if (parts.length == 2 && parts[0] == 'access_token') {
        return parts[1];
      }
    }
    return null;
  }

  Future<Map<String, dynamic>> getFirebaseResponse() async {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDixuYTZZJ3mXx8vAo7-0bB48ZM7fOV_HY",
        authDomain: "doffa-95e0a.firebaseapp.com",
        projectId: "doffa-95e0a",
        storageBucket: "doffa-95e0a.firebasestorage.app",
        messagingSenderId: "77689229480",
        appId: "1:77689229480:web:d0797e121a25a22b21329d",
        measurementId: "G-95W75NL2KF",
      ),
    );

    // Activate Firebase App Check
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider(
        '6LcAsv4qAAAAABxG7_vH_etEREH53j7A6dT2KoVZ',
      ),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );

    // Fetch the authorization code using WebAuth
    final result = await FlutterWebAuth2.authenticate(
      url: WithingsConstants.getWithingsOAuthUrl(),
      callbackUrlScheme: WithingsConstants.callbackUrlScheme,
    );
    final uri = Uri.parse(result);
    final code = uri.queryParameters['code'];

    if (code == null) {
      _logger.e("Error: Unable to retrieve code.");
      return {};
    }

    // Call the Firebase function with the authorization code and environment
    final HttpsCallable callable = FirebaseFunctions.instanceFor(
      region: "europe-west4",
    ).httpsCallable('onCallWithingsAuth');

    final response = await callable.call({
      'code': code,
      'env': WithingsConstants.env,
    });

    return response.data;
  }

  Future<Map<String, dynamic>> getDemoResponse() async {
    const String url = "https://wbsapi.withings.net/v2/oauth2";

    final String timeStamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final String nonce = await getNonce(timeStamp);

    String rawData = "getdemoaccess,${WithingsConstants.clientId},$nonce";
    String signature = generateSignature("getdemoaccess", rawData);

    final Map<String, String> payload = {
      "action": "getdemoaccess",
      "client_id": WithingsConstants.clientId,
      "nonce": nonce,
      "signature": signature,
      "timestamp":
          timeStamp, // Some APIs expect timestamp in the request, even if it's not signed
      "scope_oauth2": WithingsConstants.scope,
    };

    _logger.i("Calling demo endpoint with payload: $payload");

    try {
      final response = await http.post(Uri.parse(url), body: payload);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 0) {
          return {
            'at': data['body']['access_token'],
            'rt': data['body']['refresh_token'],
            'uid': "Demo_123456",
          };
        }
      }
      _logger.e("HTTP status error: ${response.statusCode} - ${response.body}");
    } catch (e, stacktrace) {
      _logger.e("Demo request failed", error: e, stackTrace: stacktrace);
    }

    return {};
  }

  Future<String> getNonce(String timestamp) async {
    const String url = "https://wbsapi.withings.net/v2/signature";

    String rawData = "getnonce,${WithingsConstants.clientId},$timestamp";
    String signature = generateSignature("getnonce", rawData);

    final Map<String, String> payload = {
      "action": "getnonce",
      "client_id": WithingsConstants.clientId,
      "timestamp": timestamp,
      "signature": signature,
    };

    _logger.i("Fetching Nonce with payload: $payload");

    try {
      final response = await http.post(Uri.parse(url), body: payload);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 0) {
          return data['body']['nonce'];
        }
      }
      _logger.e("Nonce request failed: ${response.body}");
    } catch (e) {
      _logger.e("Nonce request failed: $e");
    }

    throw Exception("Error: Unable to fetch nonce.");
  }

  String generateSignature(String action, String valueToSign) {
    const String clientSecret = "";

    if (clientSecret.isEmpty) {
      throw Exception("Client secret is empty or null.");
    }

    // Debugging: Log the raw data string before signing
    _logger.i("Raw data string: $valueToSign");

    var key = utf8.encode(clientSecret);
    var bytes = utf8.encode(valueToSign);

    var hmacSha256 = Hmac(sha256, key);
    Digest hash = hmacSha256.convert(bytes);

    String signature = hash.toString();
    _logger.i("Generated Signature: $signature");

    return signature;
  }
}

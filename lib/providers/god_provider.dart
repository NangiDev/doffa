import 'package:doffa/api/api_service.dart';
import 'package:doffa/api/demo_api_service.dart';
import 'package:flutter/material.dart';

// One provider to rule them all
class GodProvider extends ChangeNotifier {
  ApiService _apiService = DemoApiService();
  ApiService get apiService => _apiService;

  set apiService(ApiService service) {
    _apiService = service;
    notifyListeners();
  }

  Future<void> logIn() async {
    await _apiService.login();
    notifyListeners();
  }

  Future<void> logOut() async {
    await _apiService.logout();
    notifyListeners();
  }

  Future<void> refreshLoginStatus() async {
    notifyListeners(); // trigger rebuild after external login change
  }
}

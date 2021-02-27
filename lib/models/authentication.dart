import 'dart:convert';
import 'dart:async';
import 'dart:html';
import 'dart:io';
import '../models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyANvx_fpizX4CREqf8AXgnNzi1idmSx2ZM';
    try {
      final res = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(res.body);
      if (responseData['error'] != null) {
        HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresId'])));
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(
      String email, String password) async{
    return _authenticate(email, password, 'signUp');
  }
  Future<void> logiN(
      String email, String password) async{
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')) return false;

    final extractedData = json.decode(prefs.getString('userData')) as Map<String,Object>;

    final expiryDate = DateTime.parse(extractedData['expiryDate']);
    if(_expiryDate.isBefore(DateTime.now())) return false;
    _token =extractedData['token'];
    _userId = extractedData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }


}




















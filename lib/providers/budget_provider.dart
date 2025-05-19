import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetProvider with ChangeNotifier {
  String _budget = '0';
  String _productDetails = '';
  String _userName = '';
  String _userInterests = '';
  int _userAge = 0;
  String _userGender = '';
  String _conversationHistory = '';

  String get budget => _budget;
  String get productDetails => _productDetails;
  String get userName => _userName;
  String get userInterests => _userInterests;
  int get userAge => _userAge;
  String get userGender => _userGender;
  String get conversationHistory => _conversationHistory;

  void setBudget(String newBudget) {
    _budget = newBudget;
    _saveToPreferences();
    notifyListeners();
  }

  void setProductDetails(String details) {
    _productDetails = details;
    _saveToPreferences();
    notifyListeners();
  }

  void setUserName(String name) {
    _userName = name;
    _saveToPreferences();
    notifyListeners();
  }

  void setUserInterests(String interests) {
    _userInterests = interests;
    _saveToPreferences();
    notifyListeners();
  }

  void setUserAge(int age) {
    _userAge = age;
    _saveToPreferences();
    notifyListeners();
  }

  void setUserGender(String gender) {
    _userGender = gender;
    _saveToPreferences();
    notifyListeners();
  }

  void setConversationHistory(String history) {
    _conversationHistory = history;
    _saveToPreferences();
    notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('budget', _budget);
    await prefs.setString('productDetails', _productDetails);
    await prefs.setString('userName', _userName);
    await prefs.setString('userInterests', _userInterests);
    await prefs.setInt('userAge', _userAge);
    await prefs.setString('userGender', _userGender);
    await prefs.setString('conversationHistory', _conversationHistory);
  }

  Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _budget = prefs.getString('budget') ?? '0';
    _productDetails = prefs.getString('productDetails') ?? '';
    _userName = prefs.getString('userName') ?? '';
    _userInterests = prefs.getString('userInterests') ?? '';
    _userAge = prefs.getInt('userAge') ?? 0;
    _userGender = prefs.getString('userGender') ?? '';
    _conversationHistory = prefs.getString('conversationHistory') ?? '';
    notifyListeners();
  }
}

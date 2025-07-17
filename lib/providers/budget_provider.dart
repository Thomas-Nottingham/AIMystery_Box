import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetProvider with ChangeNotifier {
  String _budget = '';
  String _productDetails = '';
  int _userAge = 0;
  String _userGender = '';
  String _userInterests = '';
  String _conversationHistory = '';
  String _giftSummary = ''; // --- NEW ---

  String get budget => _budget;
  String get productDetails => _productDetails;
  int get userAge => _userAge;
  String get userGender => _userGender;
  String get userInterests => _userInterests;
  String get conversationHistory => _conversationHistory;
  String get giftSummary => _giftSummary; // --- NEW ---

  BudgetProvider() {
    loadFromPreferences();
  }

  void setBudget(String budget) {
    _budget = budget;
    _saveToPreferences();
    notifyListeners();
  }

  void setProductDetails(String details) {
    _productDetails = details;
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

  void setUserInterests(String interests) {
    _userInterests = interests;
    _saveToPreferences();
    notifyListeners();
  }

  void setConversationHistory(String history) {
    _conversationHistory = history;
    _saveToPreferences();
    notifyListeners();
  }

  // --- NEW ---
  void setGiftSummary(String summary) {
    _giftSummary = summary;
    notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('budget', _budget);
    await prefs.setString('productDetails', _productDetails);
    await prefs.setInt('userAge', _userAge);
    await prefs.setString('userGender', _userGender);
    await prefs.setString('userInterests', _userInterests);
    await prefs.setString('conversationHistory', _conversationHistory);
  }

  Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _budget = prefs.getString('budget') ?? '';
    _productDetails = prefs.getString('productDetails') ?? '';
    _userAge = prefs.getInt('userAge') ?? 0;
    _userGender = prefs.getString('userGender') ?? '';
    _userInterests = prefs.getString('userInterests') ?? '';
    _conversationHistory = prefs.getString('conversationHistory') ?? '';
    notifyListeners();
  }
}

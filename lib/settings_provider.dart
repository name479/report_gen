import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String? _collegeLogoPath;
  String? _profilePicturePath; // New variable for the profile picture
  String _employeeName = 'Employee';
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en', '');

  String? get collegeLogoPath => _collegeLogoPath;
  String? get profilePicturePath => _profilePicturePath; // New getter
  String get employeeName => _employeeName;
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _collegeLogoPath = prefs.getString('collegeLogoPath');
    _profilePicturePath = prefs.getString('profilePicturePath'); // Load the new path
    _employeeName = prefs.getString('employeeName') ?? 'Employee';
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    final languageCode = prefs.getString('languageCode') ?? 'en';
    _locale = Locale(languageCode, '');
    notifyListeners();
  }

  Future<void> _saveCollegeLogo(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('collegeLogoPath', path);
  }

  Future<void> _saveProfilePicture(String path) async { // Save the new path
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePicturePath', path);
  }

  Future<void> _saveEmployeeName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('employeeName', name);
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  Future<void> _saveLanguage(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLocale.languageCode);
  }

  void setCollegeLogo(String path) {
    _collegeLogoPath = path;
    _saveCollegeLogo(path);
    notifyListeners();
  }

  void setProfilePicture(String path) { // New setter
    _profilePicturePath = path;
    _saveProfilePicture(path);
    notifyListeners();
  }

  void setEmployeeName(String name) {
    _employeeName = name;
    _saveEmployeeName(name);
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(isDark);
    notifyListeners();
  }

  void setLanguage(Locale newLocale) {
    if (_locale == newLocale) return;
    _locale = newLocale;
    _saveLanguage(newLocale);
    notifyListeners();
  }
}
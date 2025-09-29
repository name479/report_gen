import 'package:flutter/material.dart';
import 'package:report/models/report_model.dart';
import 'package:report/services/database_service.dart';

class ReportsProvider with ChangeNotifier {
  List<Report> _reports = [];
  bool _isLoading = true;

  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;

  Future<void> fetchAllReports() async {
    _isLoading = true;
    notifyListeners();
    _reports = await DatabaseService().getAllReports();
    _isLoading = false;
    notifyListeners();
  }

  List<Report> getRecentReports() {
    if (_reports.isEmpty) return [];
    // يعيد أحدث تقريرين
    return _reports.take(2).toList();
  }
}
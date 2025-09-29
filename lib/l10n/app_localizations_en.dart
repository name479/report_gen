// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Report App';

  @override
  String get homePageTitle => 'My Reports';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get appearance => 'APPEARANCE';

  @override
  String get account => 'ACCOUNT';

  @override
  String get changeEmployeeName => 'Change Employee Name';

  @override
  String get newNameHint => 'New Name';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get addCollegeLogo => 'College Logo';

  @override
  String get collegeLogoAdded => 'College logo added successfully!';

  @override
  String get newReport => 'New Report';

  @override
  String get reportTitle => 'Report Title';

  @override
  String get studentName => 'Student Name';

  @override
  String get secondStudentName => 'Second Student Name (Optional)';

  @override
  String get collegeName => 'College Name';

  @override
  String get departmentName => 'Department Name';

  @override
  String get introduction => 'Introduction';

  @override
  String get objectives => 'Objectives';

  @override
  String get methodology => 'Methodology';

  @override
  String get results => 'Results';

  @override
  String get conclusion => 'Conclusion';

  @override
  String get pickLogo => 'Pick Logo';

  @override
  String get generatePdf => 'Generate PDF';

  @override
  String get generating => 'Generating...';

  @override
  String get reportSavedSuccessfully => 'Report generated and saved successfully!';

  @override
  String get pdfGenerationFailed => 'Failed to generate PDF or save report.';

  @override
  String get fillAllFields => 'Please fill all required fields to generate the report.';

  @override
  String preparedByAnd(Object firstStudent, Object secondStudent) {
    return 'Prepared by: $firstStudent and $secondStudent';
  }

  @override
  String get preparedByAnd_description => 'A description for the \'preparedByAnd\' string.';

  @override
  String preparedBy(Object studentName) {
    return 'Prepared by: $studentName';
  }

  @override
  String get preparedBy_description => 'A description for the \'preparedBy\' string.';

  @override
  String get academicYear => 'Academic Year: 2025 - 2026';

  @override
  String get noContentProvided => 'No content provided.';

  @override
  String get home => 'Home';

  @override
  String get reports => 'Reports';

  @override
  String get settings => 'Settings';

  @override
  String get createANewReport => 'Create a New Report';

  @override
  String get enterDetails => 'Enter details and generate a PDF report.';

  @override
  String get recentReports => 'Recent Reports';

  @override
  String get noRecentReports => 'No recent reports available.';

  @override
  String get goodMorning => 'Good morning,';

  @override
  String get goodAfternoon => 'Good afternoon,';

  @override
  String get goodEvening => 'Good evening,';

  @override
  String onDate(Object day, Object month, Object year) {
    return 'on $day/$month/$year';
  }

  @override
  String get onDate_description => 'A description for the \'onDate\' string.';

  @override
  String daysAgo(Object days) {
    return '$days days ago';
  }

  @override
  String get daysAgo_description => 'A description for the \'daysAgo\' string.';

  @override
  String hoursAgo(Object hours) {
    return '$hours hours ago';
  }

  @override
  String get hoursAgo_description => 'A description for the \'hoursAgo\' string.';

  @override
  String minutesAgo(Object minutes) {
    return '$minutes minutes ago';
  }

  @override
  String get minutesAgo_description => 'A description for the \'minutesAgo\' string.';

  @override
  String get justNow => 'Just now';

  @override
  String get updated => 'Updated:';

  @override
  String get share => 'Share';

  @override
  String get delete => 'Delete';

  @override
  String get pdfNotFound => 'PDF file not found.';

  @override
  String get deleteAllReports => 'Delete All Reports';

  @override
  String get areYouSureToDeleteAll => 'Are you sure you want to delete all reports? This action cannot be undone.';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get allReportsDeleted => 'All reports have been deleted successfully.';

  @override
  String get searchReports => 'Search reports...';

  @override
  String get noReportsFound => 'No reports found.';

  @override
  String get reportLanguage => 'Report Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get ministryTitle => 'Ministry of Higher Education and Scientific Research';

  @override
  String get permissionPermanentlyDenied => 'The application does not have permission to access your photos. Please enable it in the device settings.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get reportDeletedSuccessfully => 'Report deleted successfully.';
}

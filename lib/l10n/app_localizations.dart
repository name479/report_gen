import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Report App'**
  String get appTitle;

  /// No description provided for @homePageTitle.
  ///
  /// In en, this message translates to:
  /// **'My Reports'**
  String get homePageTitle;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearance;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get account;

  /// No description provided for @changeEmployeeName.
  ///
  /// In en, this message translates to:
  /// **'Change Employee Name'**
  String get changeEmployeeName;

  /// No description provided for @newNameHint.
  ///
  /// In en, this message translates to:
  /// **'New Name'**
  String get newNameHint;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @addCollegeLogo.
  ///
  /// In en, this message translates to:
  /// **'College Logo'**
  String get addCollegeLogo;

  /// No description provided for @collegeLogoAdded.
  ///
  /// In en, this message translates to:
  /// **'College logo added successfully!'**
  String get collegeLogoAdded;

  /// No description provided for @newReport.
  ///
  /// In en, this message translates to:
  /// **'New Report'**
  String get newReport;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Title'**
  String get reportTitle;

  /// No description provided for @studentName.
  ///
  /// In en, this message translates to:
  /// **'Student Name'**
  String get studentName;

  /// No description provided for @secondStudentName.
  ///
  /// In en, this message translates to:
  /// **'Second Student Name (Optional)'**
  String get secondStudentName;

  /// No description provided for @collegeName.
  ///
  /// In en, this message translates to:
  /// **'College Name'**
  String get collegeName;

  /// No description provided for @departmentName.
  ///
  /// In en, this message translates to:
  /// **'Department Name'**
  String get departmentName;

  /// No description provided for @introduction.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get introduction;

  /// No description provided for @objectives.
  ///
  /// In en, this message translates to:
  /// **'Objectives'**
  String get objectives;

  /// No description provided for @methodology.
  ///
  /// In en, this message translates to:
  /// **'Methodology'**
  String get methodology;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @conclusion.
  ///
  /// In en, this message translates to:
  /// **'Conclusion'**
  String get conclusion;

  /// No description provided for @pickLogo.
  ///
  /// In en, this message translates to:
  /// **'Pick Logo'**
  String get pickLogo;

  /// No description provided for @generatePdf.
  ///
  /// In en, this message translates to:
  /// **'Generate PDF'**
  String get generatePdf;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// No description provided for @reportSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Report generated and saved successfully!'**
  String get reportSavedSuccessfully;

  /// No description provided for @pdfGenerationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate PDF or save report.'**
  String get pdfGenerationFailed;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields to generate the report.'**
  String get fillAllFields;

  /// No description provided for @preparedByAnd.
  ///
  /// In en, this message translates to:
  /// **'Prepared by: {firstStudent} and {secondStudent}'**
  String preparedByAnd(Object firstStudent, Object secondStudent);

  /// No description provided for @preparedByAnd_description.
  ///
  /// In en, this message translates to:
  /// **'A description for the \'preparedByAnd\' string.'**
  String get preparedByAnd_description;

  /// No description provided for @preparedBy.
  ///
  /// In en, this message translates to:
  /// **'Prepared by: {studentName}'**
  String preparedBy(Object studentName);

  /// No description provided for @preparedBy_description.
  ///
  /// In en, this message translates to:
  /// **'A description for the \'preparedBy\' string.'**
  String get preparedBy_description;

  /// No description provided for @academicYear.
  ///
  /// In en, this message translates to:
  /// **'Academic Year: 2025 - 2026'**
  String get academicYear;

  /// No description provided for @noContentProvided.
  ///
  /// In en, this message translates to:
  /// **'No content provided.'**
  String get noContentProvided;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @createANewReport.
  ///
  /// In en, this message translates to:
  /// **'Create a New Report'**
  String get createANewReport;

  /// No description provided for @enterDetails.
  ///
  /// In en, this message translates to:
  /// **'Enter details and generate a PDF report.'**
  String get enterDetails;

  /// No description provided for @recentReports.
  ///
  /// In en, this message translates to:
  /// **'Recent Reports'**
  String get recentReports;

  /// No description provided for @noRecentReports.
  ///
  /// In en, this message translates to:
  /// **'No recent reports available.'**
  String get noRecentReports;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon,'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening,'**
  String get goodEvening;

  /// No description provided for @onDate.
  ///
  /// In en, this message translates to:
  /// **'on {day}/{month}/{year}'**
  String onDate(Object day, Object month, Object year);

  /// No description provided for @onDate_description.
  ///
  /// In en, this message translates to:
  /// **'A description for the \'onDate\' string.'**
  String get onDate_description;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(Object days);

  /// No description provided for @daysAgo_description.
  ///
  /// In en, this message translates to:
  /// **'A description for the \'daysAgo\' string.'**
  String get daysAgo_description;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hoursAgo(Object hours);

  /// No description provided for @hoursAgo_description.
  ///
  /// In en, this message translates to:
  /// **'A description for the \'hoursAgo\' string.'**
  String get hoursAgo_description;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutesAgo(Object minutes);

  /// No description provided for @minutesAgo_description.
  ///
  /// In en, this message translates to:
  /// **'A description for the \'minutesAgo\' string.'**
  String get minutesAgo_description;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @updated.
  ///
  /// In en, this message translates to:
  /// **'Updated:'**
  String get updated;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @pdfNotFound.
  ///
  /// In en, this message translates to:
  /// **'PDF file not found.'**
  String get pdfNotFound;

  /// No description provided for @deleteAllReports.
  ///
  /// In en, this message translates to:
  /// **'Delete All Reports'**
  String get deleteAllReports;

  /// No description provided for @areYouSureToDeleteAll.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all reports? This action cannot be undone.'**
  String get areYouSureToDeleteAll;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// No description provided for @allReportsDeleted.
  ///
  /// In en, this message translates to:
  /// **'All reports have been deleted successfully.'**
  String get allReportsDeleted;

  /// No description provided for @searchReports.
  ///
  /// In en, this message translates to:
  /// **'Search reports...'**
  String get searchReports;

  /// No description provided for @noReportsFound.
  ///
  /// In en, this message translates to:
  /// **'No reports found.'**
  String get noReportsFound;

  /// No description provided for @reportLanguage.
  ///
  /// In en, this message translates to:
  /// **'Report Language'**
  String get reportLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @ministryTitle.
  ///
  /// In en, this message translates to:
  /// **'Ministry of Higher Education and Scientific Research'**
  String get ministryTitle;

  /// No description provided for @permissionPermanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'The application does not have permission to access your photos. Please enable it in the device settings.'**
  String get permissionPermanentlyDenied;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @reportDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Report deleted successfully.'**
  String get reportDeletedSuccessfully;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

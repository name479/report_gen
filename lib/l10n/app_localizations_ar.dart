// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق التقارير';

  @override
  String get homePageTitle => 'تقاريري';

  @override
  String get settingsPageTitle => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الليلي';

  @override
  String get language => 'اللغة';

  @override
  String get appearance => 'المظهر';

  @override
  String get account => 'الحساب';

  @override
  String get changeEmployeeName => 'تغيير اسم الموظف';

  @override
  String get newNameHint => 'الاسم الجديد';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get addCollegeLogo => 'شعار الكلية';

  @override
  String get collegeLogoAdded => 'تم إضافة شعار الكلية بنجاح!';

  @override
  String get newReport => 'تقرير جديد';

  @override
  String get reportTitle => 'عنوان التقرير';

  @override
  String get studentName => 'اسم الطالب';

  @override
  String get secondStudentName => 'اسم الطالب الثاني (اختياري)';

  @override
  String get collegeName => 'اسم الكلية';

  @override
  String get departmentName => 'اسم القسم';

  @override
  String get introduction => 'المقدمة';

  @override
  String get objectives => 'الأهداف';

  @override
  String get methodology => 'المنهجية';

  @override
  String get results => 'النتائج';

  @override
  String get conclusion => 'الخلاصة';

  @override
  String get pickLogo => 'اختيار شعار';

  @override
  String get generatePdf => 'إنشاء ملف PDF';

  @override
  String get generating => 'جارٍ الإنشاء...';

  @override
  String get reportSavedSuccessfully => 'تم إنشاء التقرير وحفظه بنجاح!';

  @override
  String get pdfGenerationFailed => 'فشل في إنشاء ملف PDF أو حفظ التقرير.';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول المطلوبة لإنشاء التقرير.';

  @override
  String preparedByAnd(Object firstStudent, Object secondStudent) {
    return 'إعداد الطالبين: $firstStudent و$secondStudent';
  }

  @override
  String get preparedByAnd_description => 'A description for the \'preparedByAnd\' string.';

  @override
  String preparedBy(Object studentName) {
    return 'إعداد الطالب: $studentName';
  }

  @override
  String get preparedBy_description => 'A description for the \'preparedBy\' string.';

  @override
  String get academicYear => 'العام الدراسي: 2025 - 2026';

  @override
  String get noContentProvided => 'لم يتم توفير أي محتوى.';

  @override
  String get home => 'الرئيسية';

  @override
  String get reports => 'التقارير';

  @override
  String get settings => 'الإعدادات';

  @override
  String get createANewReport => 'إنشاء تقرير جديد';

  @override
  String get enterDetails => 'أدخل التفاصيل وأنشئ تقرير PDF.';

  @override
  String get recentReports => 'التقارير الأخيرة';

  @override
  String get noRecentReports => 'لا توجد تقارير حديثة.';

  @override
  String get goodMorning => 'صباح الخير،';

  @override
  String get goodAfternoon => 'مساء الخير،';

  @override
  String get goodEvening => 'مساء الخير،';

  @override
  String onDate(Object day, Object month, Object year) {
    return 'في $day/$month/$year';
  }

  @override
  String get onDate_description => 'A description for the \'onDate\' string.';

  @override
  String daysAgo(Object days) {
    return 'منذ $days أيام';
  }

  @override
  String get daysAgo_description => 'A description for the \'daysAgo\' string.';

  @override
  String hoursAgo(Object hours) {
    return 'منذ $hours ساعات';
  }

  @override
  String get hoursAgo_description => 'A description for the \'hoursAgo\' string.';

  @override
  String minutesAgo(Object minutes) {
    return 'منذ $minutes دقائق';
  }

  @override
  String get minutesAgo_description => 'A description for the \'minutesAgo\' string.';

  @override
  String get justNow => 'الآن';

  @override
  String get updated => 'تحديث:';

  @override
  String get share => 'مشاركة';

  @override
  String get delete => 'حذف';

  @override
  String get pdfNotFound => 'ملف PDF غير موجود.';

  @override
  String get deleteAllReports => 'حذف كل التقارير';

  @override
  String get areYouSureToDeleteAll => 'هل أنت متأكد من أنك تريد حذف جميع التقارير؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteAll => 'حذف الكل';

  @override
  String get allReportsDeleted => 'تم حذف جميع التقارير بنجاح.';

  @override
  String get searchReports => 'البحث في التقارير...';

  @override
  String get noReportsFound => 'لم يتم العثور على تقارير.';

  @override
  String get reportLanguage => 'لغة التقرير';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get ministryTitle => 'وزارة التعليم العالي والبحث العلمي';

  @override
  String get permissionPermanentlyDenied => 'لا يملك التطبيق إذن الوصول إلى صورك. يرجى تفعيله من إعدادات الجهاز.';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get reportDeletedSuccessfully => 'تم حذف التقرير بنجاح';
}

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:report/models/report_model.dart';
import 'package:report/services/database_service.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';
import 'package:report/settings_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';

import 'l10n/app_localizations.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _introController = TextEditingController();
  final TextEditingController _objectivesController = TextEditingController();
  final TextEditingController _methodController = TextEditingController();
  final TextEditingController _resultsController = TextEditingController();
  final TextEditingController _conclusionController = TextEditingController();
  bool _isGeneratingPdf = false;
  String _selectedLanguage = 'ar';

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
    _nameController.addListener(() => setState(() {}));
    _secondNameController.addListener(() => setState(() {}));
    _collegeController.addListener(() => setState(() {}));
    _departmentController.addListener(() => setState(() {}));
    _introController.addListener(() => setState(() {}));
    _objectivesController.addListener(() => setState(() {}));
    _methodController.addListener(() => setState(() {}));
    _resultsController.addListener(() => setState(() {}));
    _conclusionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _nameController.dispose();
    _secondNameController.dispose();
    _collegeController.dispose();
    _departmentController.dispose();
    _introController.dispose();
    _objectivesController.dispose();
    _methodController.dispose();
    _resultsController.dispose();
    _conclusionController.dispose();
    super.dispose();
  }

  Future<void> _saveReportAndGeneratePdf() async {
    final localizations = AppLocalizations.of(context)!;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isGeneratingPdf = true;
      });

      try {
        final pdfData = await _generatePdf();
        final output = await getTemporaryDirectory();
        final String fileName = "report_${DateTime.now().millisecondsSinceEpoch}.pdf";
        final file = File('${output.path}/$fileName');
        await file.writeAsBytes(pdfData);

        final newReport = Report(
          title: _titleController.text,
          name: _nameController.text,
          intro: _introController.text,
          objectives: _objectivesController.text,
          method: _methodController.text,
          results: _resultsController.text,
          conclusion: _conclusionController.text,
          dateCreated: DateTime.now(),
          pdfPath: file.path,
        );

        await DatabaseService().insertReport(newReport);

        if (!mounted) return;
        await Printing.layoutPdf(onLayout: (format) async => pdfData);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.reportSavedSuccessfully),
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.pdfGenerationFailed),
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        if (!mounted) return;
        setState(() {
          _isGeneratingPdf = false;
        });
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.fillAllFields),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Map<String, String> _getLocalizedStringsForPdf(String langCode) {
    if (langCode == 'en') {
      return {
        'ministryTitle': 'Ministry of Higher Education and Scientific Research',
        'academicYear': 'Academic Year:',
        'preparedBy': 'Prepared by:',
        'preparedByAnd': 'Prepared by: %s and %s',
        'introduction': 'Introduction',
        'objectives': 'Objectives',
        'methodology': 'Methodology',
        'results': 'Results',
        'conclusion': 'Conclusion',
        'noContentProvided': 'No content provided.',
      };
    } else {
      return {
        'ministryTitle': 'وزارة التعليم العالي والبحث العلمي',
        'academicYear': 'العام الدراسي:',
        'preparedBy': 'إعداد الطالب:',
        'preparedByAnd': 'إعداد الطالبين: %s و %s',
        'introduction': 'المقدمة',
        'objectives': 'الأهداف',
        'methodology': 'المنهجية',
        'results': 'النتائج',
        'conclusion': 'الخلاصة',
        'noContentProvided': 'لم يتم إدخال محتوى.',
      };
    }
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    final localizations = AppLocalizations.of(context)!;
    final pdfStrings = _getLocalizedStringsForPdf(_selectedLanguage);

    final amiriFontData = await rootBundle.load('assets/fonts/Amiri/Amiri-Regular.ttf');
    final amiriTtf = pw.Font.ttf(amiriFontData);
    final timesFontData = await rootBundle.load('assets/fonts/times-new-roman/times.ttf');
    final timesTtf = pw.Font.ttf(timesFontData);

    final pw.Font selectedFont = _selectedLanguage == 'ar' ? amiriTtf : timesTtf;
    final pw.TextDirection? textDirection = _selectedLanguage == 'ar' ? pw.TextDirection.rtl : pw.TextDirection.ltr;

    pw.MemoryImage? universityLogo;
    try {
      final universityLogoData = (await rootBundle.load('assets/images/university_logo.png')).buffer.asUint8List();
      universityLogo = pw.MemoryImage(universityLogoData);
    } catch (e) {
      universityLogo = null;
    }

    // Fixed college logo
    pw.MemoryImage? collegeLogo;
    try {
      final collegeLogoData = (await rootBundle.load('assets/images/college_logo.png')).buffer.asUint8List();
      collegeLogo = pw.MemoryImage(collegeLogoData);
    } catch (e) {
      collegeLogo = null;
    }

    final currentYear = DateTime.now().year;
    final academicYearText = '${pdfStrings['academicYear']} ${currentYear}-${currentYear + 1}';
    final formattedDate = _selectedLanguage == 'ar'
        ? DateFormat('d MMMM y', 'ar').format(DateTime.now())
        : DateFormat('MMMM d, y').format(DateTime.now());

    final String preparedByText = _secondNameController.text.isNotEmpty
        ? pdfStrings['preparedByAnd']!.replaceFirst('%s', _nameController.text).replaceFirst('%s', _secondNameController.text)
        : '${pdfStrings['preparedBy']} ${_nameController.text}';

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    if (universityLogo != null)
                      pw.Image(universityLogo, width: 300, height: 200, fit: pw.BoxFit.contain)
                    else
                      pw.SizedBox(width: 300, height: 200),
                    if (collegeLogo != null)
                      pw.Image(
                        collegeLogo,
                        width: 150,
                        height: 150,
                        fit: pw.BoxFit.contain,
                      )
                    else
                      pw.SizedBox(width: 150, height: 150),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  pdfStrings['ministryTitle']!,
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: selectedFont),
                  textAlign: pw.TextAlign.center,
                  textDirection: textDirection,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  _collegeController.text,
                  style: pw.TextStyle(fontSize: 16, font: selectedFont),
                  textDirection: textDirection,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  _departmentController.text,
                  style: pw.TextStyle(fontSize: 16, font: selectedFont),
                  textDirection: textDirection,
                ),
                pw.SizedBox(height: 50),
                pw.Text(
                  _titleController.text,
                  style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, font: selectedFont),
                  textAlign: pw.TextAlign.center,
                  textDirection: textDirection,
                ),
                pw.SizedBox(height: 50),
                pw.Text(
                  preparedByText,
                  style: pw.TextStyle(fontSize: 16, font: selectedFont),
                  textDirection: textDirection,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  academicYearText,
                  style: pw.TextStyle(fontSize: 16, font: selectedFont),
                  textDirection: textDirection,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  formattedDate,
                  style: pw.TextStyle(fontSize: 16, font: selectedFont),
                  textDirection: textDirection,
                ),
              ],
            ),
          );
        },
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: textDirection,
        build: (pw.Context context) {
          return [
            _buildSection(pdfStrings['introduction']!, _introController.text, selectedFont, textDirection),
            _buildSection(pdfStrings['objectives']!, _objectivesController.text, selectedFont, textDirection),
            _buildSection(pdfStrings['methodology']!, _methodController.text, selectedFont, textDirection),
            _buildSection(pdfStrings['results']!, _resultsController.text, selectedFont, textDirection),
            _buildSection(pdfStrings['conclusion']!, _conclusionController.text, selectedFont, textDirection),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildSection(String title, String content, pw.Font font, pw.TextDirection? textDirection) {
    final pdfStrings = _getLocalizedStringsForPdf(_selectedLanguage);
    return pw.Column(
      crossAxisAlignment: textDirection == pw.TextDirection.rtl ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          alignment: textDirection == pw.TextDirection.rtl ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
          child: pw.Text(
            title,
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: font),
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          content.isEmpty ? pdfStrings['noContentProvided']! : content,
          style: pw.TextStyle(fontSize: 14, font: font),
          textAlign: textDirection == pw.TextDirection.rtl ? pw.TextAlign.right : pw.TextAlign.left,
          textDirection: textDirection,
        ),
        pw.SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(localizations.newReport),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _titleController,
                  labelText: localizations.reportTitle,
                  icon: Icons.title,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _nameController,
                  labelText: localizations.studentName,
                  icon: Icons.person,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _secondNameController,
                  labelText: localizations.secondStudentName,
                  icon: Icons.person_add,
                  isRequired: false,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _collegeController,
                  labelText: localizations.collegeName,
                  icon: Icons.school,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _departmentController,
                  labelText: localizations.departmentName,
                  icon: Icons.engineering,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedLanguage,
                  decoration: InputDecoration(
                    labelText: localizations.reportLanguage,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(localizations.english),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text(localizations.arabic),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _introController,
                  labelText: localizations.introduction,
                  icon: Icons.book,
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _objectivesController,
                  labelText: localizations.objectives,
                  icon: Icons.flag,
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _methodController,
                  labelText: localizations.methodology,
                  icon: Icons.science,
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _resultsController,
                  labelText: localizations.results,
                  icon: Icons.bar_chart,
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                _buildReportField(
                  context: context,
                  isDarkMode: isDarkMode,
                  controller: _conclusionController,
                  labelText: localizations.conclusion,
                  icon: Icons.check_circle,
                  maxLines: null,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isGeneratingPdf ? null : _saveReportAndGeneratePdf,
                        icon: _isGeneratingPdf
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Icon(Icons.picture_as_pdf, color: Colors.white),
                        label: _isGeneratingPdf
                            ? Text(localizations.generating, style: const TextStyle(color: Colors.white))
                            : Text(localizations.generatePdf, style: const TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportField({
    required BuildContext context,
    required bool isDarkMode,
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int? maxLines = 1,
    bool isRequired = false,
  }) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge!.color;
    final hintColor = textColor!.withOpacity(0.6);
    final localizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: hintColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: TextStyle(color: hintColor),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorStyle: const TextStyle(height: 0),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear, color: hintColor),
                  onPressed: () {
                    controller.clear();
                  },
                )
                    : null,
              ),
              maxLines: maxLines,
              validator: isRequired
                  ? (value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}


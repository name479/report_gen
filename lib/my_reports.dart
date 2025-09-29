// في ملف lib/my_reports_page.dart

import 'package:flutter/material.dart';
import 'package:report/models/report_model.dart';
import 'package:report/services/database_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';
import 'ReportsProvider.dart';
import 'l10n/app_localizations.dart';


class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _deleteReport(int id) async {
    final localizations = AppLocalizations.of(context)!;
    await DatabaseService().deleteReport(id);
    Provider.of<ReportsProvider>(context, listen: false).fetchAllReports();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(localizations.reportDeletedSuccessfully)),
    );
  }

  Future<void> _deleteAllReports() async {
    final localizations = AppLocalizations.of(context)!;
    final bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.deleteAllReports),
        content: Text(localizations.areYouSureToDeleteAll),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(localizations.deleteAll),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseService().deleteAllReports();
      Provider.of<ReportsProvider>(context, listen: false).fetchAllReports();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.allReportsDeleted)),
      );
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final localizations = AppLocalizations.of(context)!;

    if (difference.inDays > 7) {
      return localizations.onDate(
          date.day.toString(), date.month.toString(), date.year.toString());
    } else if (difference.inDays > 0) {
      return localizations.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return localizations.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return localizations.minutesAgo(difference.inMinutes);
    } else {
      return localizations.justNow;
    }
  }

  Widget _buildReportCard(Report report, BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () async {
        if (report.pdfPath != null) {
          await OpenFilex.open(report.pdfPath!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.pdfNotFound)),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.red.shade900 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.description_outlined,
                  color: isDarkMode ? Colors.red.shade200 : Colors.red),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge!.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${localizations.updated} ${_formatDate(report.dateCreated)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.textTheme.bodySmall!.color,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: theme.iconTheme.color),
              onSelected: (value) async {
                if (value == 'share') {
                  if (report.pdfPath != null) {
                    await Share.shareXFiles(
                      [XFile(report.pdfPath!)],
                      text: 'Check out this report: ${report.title}',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(localizations.pdfNotFound)),
                    );
                  }
                } else if (value == 'delete') {
                  await _deleteReport(report.id!);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'share',
                  child: Text(localizations.share),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(localizations.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reportsProvider = Provider.of<ReportsProvider>(context);
    final reports = reportsProvider.reports;
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final filteredReports = reports.where((report) {
      final query = _searchController.text.toLowerCase();
      return report.title.toLowerCase().contains(query) ||
          report.name.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Text(localizations.reports),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _deleteAllReports,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: localizations.searchReports,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: theme.cardColor,
              ),
            ),
            const SizedBox(height: 16),
            if (reportsProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (filteredReports.isEmpty)
              Center(
                child: Text(
                  localizations.noReportsFound,
                  style: TextStyle(color: theme.textTheme.bodySmall!.color),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filteredReports.length,
                  itemBuilder: (context, index) {
                    return _buildReportCard(filteredReports[index], context);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

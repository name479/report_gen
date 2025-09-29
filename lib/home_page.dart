import 'dart:io';
import 'package:flutter/material.dart';
import 'package:report/models/report_model.dart';
import 'package:report/my_reports.dart';
import 'package:report/services/database_service.dart';
import 'package:report/settings_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'ReportsProvider.dart';
import 'add_report_page.dart';
import 'l10n/app_localizations.dart';
import 'settings_page.dart';
import 'package:open_filex/open_filex.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReportsProvider>(context, listen: false).fetchAllReports();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    final localizations = AppLocalizations.of(context)!;
    if (hour < 12) {
      return localizations.goodMorning;
    } else if (hour < 17) {
      return localizations.goodAfternoon;
    } else {
      return localizations.goodEvening;
    }
  }

  Widget _buildRecentReportCard({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String updated,
    required Report report,
    required BuildContext context,
  }) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    final cardColor = Theme.of(context).cardColor;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () async {
        if (report.pdfPath != null) {
          await OpenFilex.open(report.pdfPath!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizations.pdfNotFound),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
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
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${localizations.updated} $updated',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: textColor),
              onSelected: (value) async {
                if (value == 'share') {
                  if (report.pdfPath != null) {
                    await Share.shareXFiles(
                      [XFile(report.pdfPath!)],
                      text: 'Check out this report: ${report.title}',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(localizations.pdfNotFound),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                } else if (value == 'delete') {
                  await DatabaseService().deleteReport(report.id!);
                  Provider.of<ReportsProvider>(context, listen: false)
                      .fetchAllReports();
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

  Widget _buildHomePage() {
    final reportsProvider = Provider.of<ReportsProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final recentReports = reportsProvider.getRecentReports();
    final isLoading = reportsProvider.isLoading;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_getGreeting(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).textTheme.bodySmall!.color)),
                      const SizedBox(height: 4),
                      Text(
                        settingsProvider.employeeName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.createANewReport,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            localizations.enterDetails,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).textTheme.bodySmall!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddReportPage()),
                          );
                          Provider.of<ReportsProvider>(context, listen: false)
                              .fetchAllReports();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                localizations.recentReports,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              const SizedBox(height: 16),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : recentReports.isEmpty
                  ? Center(
                child: Text(
                  localizations.noRecentReports,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color),
                ),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: recentReports.length,
                  itemBuilder: (context, index) {
                    final report = recentReports[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildRecentReportCard(
                        icon: Icons.description_outlined,
                        iconColor: Theme.of(context).colorScheme.secondary,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        title: report.title,
                        updated: _formatDate(report.dateCreated),
                        report: report,
                        context: context,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final List<Widget> pages = [
      _buildHomePage(),
      const MyReportsPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodySmall!.color,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: localizations.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.folder), label: localizations.reports),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: localizations.settings),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

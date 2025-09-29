import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report/settings_provider.dart';

import 'l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _showChangeNameDialog(BuildContext context, SettingsProvider provider) async {
    final nameController = TextEditingController(text: provider.employeeName);
    final localizations = AppLocalizations.of(context)!;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations.changeEmployeeName),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: localizations.newNameHint),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  provider.setEmployeeName(nameController.text);
                }
                Navigator.of(context).pop();
              },
              child: Text(localizations.save),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;
    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyLarge!.color;
    final hintColor = theme.textTheme.bodySmall!.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          localizations.settingsPageTitle,
          style: TextStyle(color: textColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Text(
                  localizations.appearance,
                  style: TextStyle(
                    color: hintColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingsItem(
                      icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      title: localizations.darkMode,
                      context: context,
                      trailing: Switch(
                        value: isDarkMode,
                        onChanged: (value) => settingsProvider.toggleTheme(value),
                      ),
                    ),
                    const Divider(height: 1, indent: 20, endIndent: 20),
                    _buildSettingsItem(
                      icon: Icons.language,
                      title: localizations.language,
                      context: context,
                      trailing: DropdownButton<Locale>(
                        value: settingsProvider.locale,
                        onChanged: (Locale? newLocale) {
                          if (newLocale != null) {
                            settingsProvider.setLanguage(newLocale);
                          }
                        },
                        underline: const SizedBox.shrink(),
                        icon: Icon(Icons.arrow_forward_ios, size: 16, color: hintColor),
                        items: const [
                          DropdownMenuItem(
                            value: Locale('en', ''),
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: Locale('ar', ''),
                            child: Text('العربية'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Text(
                  localizations.account,
                  style: TextStyle(
                    color: hintColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingsItem(
                      icon: Icons.person,
                      title: settingsProvider.employeeName,
                      context: context,
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: hintColor),
                        onPressed: () => _showChangeNameDialog(context, settingsProvider),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge!.color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}

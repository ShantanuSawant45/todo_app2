import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/period_provider.dart';

// period tracker
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView(
        children: [
          _buildSettingsTile(
            context,
            'Default Cycle Length',
            'Set your average cycle length',
            Icons.calendar_today,
            () {
              // TODO: Implement cycle length setting
            },
          ),
          _buildSettingsTile(
            context,
            'Notifications',
            'Configure period and ovulation reminders',
            Icons.notifications,
            () {
              // TODO: Implement notifications settings
            },
          ),
          _buildSettingsTile(
            context,
            'Export Data',
            'Export your period tracking data',
            Icons.download,
            () {
              // TODO: Implement data export
            },
          ),
          _buildSettingsTile(
            context,
            'About',
            'App version and information',
            Icons.info,
            () {
              showAboutDialog(
                context: context,
                applicationName: 'Period Tracker',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

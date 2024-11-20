import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/period.dart';
import '../providers/period_provider.dart';
import 'package:intl/intl.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PeriodProvider>(
      builder: (context, periodProvider, child) {
        final avgCycleLength = periodProvider.averageCycleLength;
        final periods = periodProvider.periods;
        final lastPeriod = periods.isNotEmpty ? periods.last : null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Insights'),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (lastPeriod != null) ...[
                _buildInsightCard(
                  context,
                  'Next Period',
                  DateFormat('MMM dd').format(lastPeriod.nextPeriodStart),
                  Icons.calendar_today,
                ),
                const SizedBox(height: 16),
                _buildInsightCard(
                  context,
                  'Next Fertile Window',
                  '${DateFormat('MMM dd').format(lastPeriod.fertilityWindow.start)} - '
                      '${DateFormat('MMM dd').format(lastPeriod.fertilityWindow.end)}',
                  Icons.favorite,
                ),
              ],
              const SizedBox(height: 16),
              _buildInsightCard(
                context,
                'Cycle Statistics',
                'Average: ${avgCycleLength.toStringAsFixed(1)} days\n'
                    'Tracked Periods: ${periods.length}',
                Icons.analytics,
              ),
              if (periods.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildRecentPeriodsCard(context, periods),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildInsightCard(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildRecentPeriodsCard(BuildContext context, List<Period> periods) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Periods',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...periods.take(5).map((period) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${DateFormat('MMM dd').format(period.startDate)} - '
                      '${DateFormat('MMM dd').format(period!.endDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

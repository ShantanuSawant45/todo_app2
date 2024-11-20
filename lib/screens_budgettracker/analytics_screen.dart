import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, _) {
        final expenses =
            provider.getTransactionsByType(TransactionType.expense);
        final categoryTotals = provider.getCategoryTotals();

        return CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: const Text('Analytics'),
              floating: true,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spending Overview',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ...categoryTotals.entries.map((entry) {
                          final percentage =
                              (entry.value / provider.totalExpenses) * 100;
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(entry.key),
                                  ),
                                  Text(
                                    '\$${entry.value.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: percentage / 100,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Summary',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSummaryItem(
                              context,
                              'Income',
                              provider.monthlyIncome,
                              Colors.green,
                            ),
                            _buildSummaryItem(
                              context,
                              'Expenses',
                              provider.monthlyExpenses,
                              Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    double amount,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

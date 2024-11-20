import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/period.dart';
import '../providers/period_provider.dart';
import '../widgets/period_form_dialog.dart';
import '../pages/insights_page.dart';
import '../pages/settings_page.dart';

class HomePage_PeriodTracker extends StatefulWidget {
  const HomePage_PeriodTracker({super.key});

  @override
  State<HomePage_PeriodTracker> createState() => _HomePage_PeriodTrackerState();
}

class _HomePage_PeriodTrackerState extends State<HomePage_PeriodTracker> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Widget _buildPredictionCard(Period? lastPeriod) {
    if (lastPeriod == null) return const SizedBox.shrink();

    final nextPeriods = lastPeriod.getNextPredictedPeriods(3);
    final nextFertileWindows = lastPeriod.getNextFertilityWindows(3);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Predictions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < nextPeriods.length; i++) ...[
              _buildPredictionItem(
                'Period ${i + 1}',
                nextPeriods[i].startDate,
                nextPeriods[i].endDate,
                Colors.pink[100]!,
              ),
              _buildPredictionItem(
                'Fertile Window ${i + 1}',
                nextFertileWindows[i].start,
                nextFertileWindows[i].end,
                Colors.green[100]!,
              ),
              const Divider(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionItem(
    String label,
    DateTime start,
    DateTime end,
    Color color,
  ) {
    final dateFormat = DateFormat('MMM dd');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color.withOpacity(0.9),
            ),
          ),
          Text(
            '${dateFormat.format(start)} - ${dateFormat.format(end)}',
            style: TextStyle(
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PeriodProvider>(
      builder: (context, periodProvider, child) {
        final lastPeriod = periodProvider.periods.isNotEmpty
            ? periodProvider.periods.last
            : null;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Period Tracker'),
                  background: Container(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(16),
                      elevation: 4,
                      child: TableCalendar(
                        firstDay: DateTime.utc(2024, 1, 1),
                        lastDay: DateTime.utc(2024, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          markerDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          outsideDaysVisible: false,
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            final periods =
                                periodProvider.getPeriodsForMonth(date);
                            for (final period in periods) {
                              if (period.containsDate(date)) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 8,
                                  height: 8,
                                );
                              }
                              if (period.isOvulationDay(date)) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 8,
                                  height: 8,
                                );
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    _buildPredictionCard(lastPeriod),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final period = await showDialog<Period>(
                context: context,
                builder: (context) => const PeriodFormDialog(),
              );
              if (period != null) {
                periodProvider.addPeriod(period);
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Period'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insights),
                label: 'Insights',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: 0,
            onTap: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InsightsPage()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }
            },
          ),
        );
      },
    );
  }
}

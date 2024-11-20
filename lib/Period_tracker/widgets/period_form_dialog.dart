import 'package:flutter/material.dart';
import '../models/period.dart';

class PeriodFormDialog extends StatefulWidget {
  final Period? period;

  const PeriodFormDialog({super.key, this.period});

  @override
  State<PeriodFormDialog> createState() => _PeriodFormDialogState();
}

class _PeriodFormDialogState extends State<PeriodFormDialog> {
  late DateTime _startDate;
  late DateTime _endDate;
  late int _cycleLength;

  @override
  void initState() {
    super.initState();
    _startDate = widget.period?.startDate ?? DateTime.now();
    _endDate =
        widget.period?.endDate ?? DateTime.now().add(const Duration(days: 5));
    _cycleLength = widget.period?.cycleLength ?? 28;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        widget.period == null ? 'Add Period' : 'Edit Period',
        style: const TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDateTile(
            context,
            'Start Date',
            _startDate,
            () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            surface: Colors.grey[850],
                          ),
                    ),
                    child: child!,
                  );
                },
              );
              if (date != null) {
                setState(() => _startDate = date);
              }
            },
          ),
          ListTile(
            title: const Text('End Date'),
            subtitle: Text(_endDate.toString().split(' ')[0]),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: _startDate,
                lastDate: DateTime(2025),
              );
              if (date != null) {
                setState(() => _endDate = date);
              }
            },
          ),
          ListTile(
            title: const Text('Cycle Length'),
            subtitle: Text('$_cycleLength days'),
            onTap: () async {
              final length = await showDialog<int>(
                context: context,
                builder: (context) => NumberPickerDialog(
                  initialValue: _cycleLength,
                  minValue: 21,
                  maxValue: 35,
                ),
              );
              if (length != null) {
                setState(() => _cycleLength = length);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final period = Period(
              startDate: _startDate,
              endDate: _endDate,
              cycleLength: _cycleLength,
            );
            Navigator.pop(context, period);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildDateTile(
    BuildContext context,
    String title,
    DateTime date,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        date.toString().split(' ')[0],
        style: TextStyle(color: Colors.grey[400]),
      ),
      onTap: onTap,
    );
  }
}

class NumberPickerDialog extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;

  const NumberPickerDialog({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
  });

  @override
  State<NumberPickerDialog> createState() => _NumberPickerDialogState();
}

class _NumberPickerDialogState extends State<NumberPickerDialog> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Cycle Length'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _value > widget.minValue
                ? () => setState(() => _value--)
                : null,
          ),
          Text('$_value days'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _value < widget.maxValue
                ? () => setState(() => _value++)
                : null,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _value),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

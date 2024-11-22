import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_health_data.dart';
import '../providers/health_providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _stepGoalController = TextEditingController();
  final _waterGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final healthData = ref.read(healthDataProvider);
    if (healthData != null) {
      _heightController.text = healthData.height.toString();
      _weightController.text = healthData.weight.toString();
      _stepGoalController.text = healthData.dailyStepGoal.toString();
      _waterGoalController.text = healthData.dailyWaterGoal.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your height';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your weight';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _stepGoalController,
              decoration: InputDecoration(
                labelText: 'Daily Step Goal',
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your daily step goal';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _waterGoalController,
              decoration: InputDecoration(
                labelText: 'Daily Water Goal (glasses)',
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your daily water goal';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final healthData = UserHealthData(
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        dailyStepGoal: int.parse(_stepGoalController.text),
        dailyWaterGoal: int.parse(_waterGoalController.text),
      );
      ref.read(healthDataProvider.notifier).updateHealthData(healthData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _stepGoalController.dispose();
    _waterGoalController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main.dart';
import 'MyHomePage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      animation: 'assets/animations/onboarding1.json',
      title: 'Task Management',
      description: 'Create, organize and track your tasks with ease.',

    ),
    OnboardingContent(
      animation: 'assets/animations/onboarding2.json',
      title: 'Smart Categories',
      description: 'Organize tasks into custom categories.\n'
          'Filter and sort tasks based on your needs.\n'
          'Keep your work and personal tasks separate.',
    ),
    OnboardingContent(
      animation: 'assets/animations/onboarding3.json',
      title: 'Progress Tracking',
      description: 'Monitor your task completion rate.\n'
          'View detailed statistics and reports.\n'
          'Stay motivated with progress insights.',
    ),
    OnboardingContent(
      animation: 'assets/animations/onboarding4.json',
      title: 'Reminders & Notifications',
      description: 'Get timely reminders for pending tasks.\n'
          'Customize notification preferences.\n'
          'Stay on top of your schedule.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _contents.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          _contents[index].animation,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _contents[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _contents[index].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicators
                  Row(
                    children: List.generate(
                      _contents.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  // Next/Get Started button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _contents.length - 1) {
                        // Navigate to main app
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                            ),
                          ),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _contents.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
    );
  }
}

class OnboardingContent {
  final String animation;
  final String title;
  final String description;

  OnboardingContent({
    required this.animation,
    required this.title,
    required this.description,
  });
}

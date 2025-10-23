import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SikovisOnboarding(),
    );
  }
}
 
class SikovisOnboarding extends StatelessWidget {
  SikovisOnboarding({super.key});

  final PageController _pageController = PageController();

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: "Everything in your hands",
      description: "With Sikovis, high-quality motorcycle workshops, and check reviews. Keep your ride in top condition with confidence!",
      imagePath: "assets/images/mechanic1.png",
    ),
    OnboardingItem(
      title: "Welcome Sikovis",
      description: "Find the best motorcycle service with just one tap! Don't miss out on the care your bike deserves—book now with Sikovis!",
      imagePath: "assets/images/mechanic2.png",
    ),
    OnboardingItem(
      title: "Loooking for service?",
      description: "Find the best motorcycle workshop around you in seconds, make a booking, and enjoy the best service experience with Sikovis.",
      imagePath: "assets/images/mechanic3.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // PageView for onboarding content
        PageView.builder(
          controller: _pageController,
          itemCount: _onboardingItems.length,
          itemBuilder: (context, index) {
            return _buildOnboardingPage(context, _onboardingItems[index]);
          },
        ),
        
        // Bottom indicator and button
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                // Get Started button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to main app
                      print("Get Started pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002A5C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingItems.length,
                    (index) => _buildPageIndicator(index),
                  ),
                ),
                
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOnboardingPage(BuildContext context, OnboardingItem item) {
    return Column(
      children: [
        // Image (taking 75% of the height)
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            color: Colors.grey[200],
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // Red bottom section with text (taking 25% of the height)
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(int index) {
    // Page indicator dots
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        int currentPage = 0;
        try {
          currentPage = _pageController.page?.round() ?? 0;
        } catch (_) {
          currentPage = 0;
        }
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 8,
          width: currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentPage == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
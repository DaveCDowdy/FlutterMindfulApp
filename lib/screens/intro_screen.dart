import 'package:flutter/material.dart';
import 'package:mindful_app/data/sp_helper.dart';
import 'package:mindful_app/screens/quote_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String name = '';
  String image = 'Lake';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final helper = SpHelper();
    helper.getSettings().then((settings) {
      setState(() {
        name = settings['name'] ?? '';
        image = settings['image'] ?? 'Lake';
        if (image == '') image = 'Lake';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/$image.jpg', fit: BoxFit.cover),
          ),
          Align(
            alignment: const Alignment(0, -0.5),
            child: Text(
              'Welcome $name',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const QuoteScreen(),
                  ),
                );
                _loadSettings();
              },
              child: const Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}

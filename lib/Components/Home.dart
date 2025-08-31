import 'dart:math'; // for pi
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mastermindv/Components/GamePage/GamePage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final colors = [
    const Color(0xFFF85F5F),
    const Color(0xFFE4F91F),
    const Color(0xFF21FF59),
    const Color(0xFF1CF6D6),
  ];

  final TextEditingController _attemptController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final int maxAttemptsLimit = 20;
  final int maxTimeLimit = 600; 
  @override
  void dispose() {
    _attemptController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _startGame() {
    int? maxAttempts = int.tryParse(_attemptController.text);
    int? timeLimit = int.tryParse(_timeController.text);

    if (maxAttempts == null ||
        timeLimit == null ||
        maxAttempts <= 0 ||
        timeLimit <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid positive numbers!")),
      );
      return;
    }

    if (maxAttempts > maxAttemptsLimit) {
      maxAttempts = maxAttemptsLimit;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Max attempts capped to $maxAttemptsLimit")),
      );
    }
    if (timeLimit > maxTimeLimit) {
      timeLimit = maxTimeLimit;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Time limit capped to $maxTimeLimit seconds")),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GamePage(maxAttempts: maxAttempts!, timeLimit: timeLimit!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4B975),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background shapes
          Positioned(
            top: 20,
            left: 50,
            child: Transform.rotate(
              angle: 160 * pi / 180,
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width + 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFFB9223),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    for (var c in colors)
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: -150,
            child: Transform.rotate(
              angle: 160 * pi / 180,
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width + 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFFB9223),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Positioned(
            top: 450,
            left: 50,
            child: Transform.rotate(
              angle: 160 * pi / 180,
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width + 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFFB9223),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),

          // Title
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ScaleAnimatedText(
                    'Master\nMindV1',
                    duration: const Duration(milliseconds: 10000),
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.irishGrover(
                      color: const Color(0xFF9C4E00),
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Input fields and button
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 220,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextField(
                      controller: _attemptController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Max Attempts",
                        labelStyle: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintText: "Enter attempts (1-$maxAttemptsLimit)",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 220,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: TextField(
                      controller: _timeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Time Limit (sec)",
                        labelStyle: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintText: "Enter time (1-$maxTimeLimit)",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.teal, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _startGame,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF85F5F),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      child: Text(
                        "Start Game",
                        style: GoogleFonts.irishGrover(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Rule extends StatefulWidget {
  const Rule({super.key});

  @override
  State<Rule> createState() => _RuleState();
}

class _RuleState extends State<Rule> {
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

    if (maxAttempts > maxAttemptsLimit) maxAttempts = maxAttemptsLimit;
    if (timeLimit > maxTimeLimit) timeLimit = maxTimeLimit;

    // Navigate to GamePage here (assume GamePage exists)
    // Navigator.push(context, MaterialPageRoute(builder: (_) => GamePage(maxAttempts: maxAttempts!, timeLimit: timeLimit!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4B975),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF85F5F),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "📜 MasterMindV Rules",
                            style: GoogleFonts.irishGrover(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildRuleRow(
                          "🎨",
                          "The computer generates a secret code of 4 colors.",
                        ),
                        _buildRuleRow(
                          "🧩",
                          "Your goal is to guess the exact sequence of colors.",
                        ),
                        _buildRuleRow(
                          "⚪",
                          "White peg: correct color in the correct position.",
                        ),
                        _buildRuleRow(
                          "⚫",
                          "Black peg: correct color in the wrong position.",
                        ),
                        _buildRuleRow(
                          "🔁",
                          "Use feedback from pegs to improve your next guess.",
                        ),
                        _buildRuleRow(
                          "⏳",
                          "Keep guessing until you find the correct sequence! Maximum attempts: 9.",
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          color: Colors.white.withOpacity(0.6),
                          thickness: 1.5,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Set Your Game:",
                          style: GoogleFonts.irishGrover(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent.shade100,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInputField(
                          _attemptController,
                          "Max Attempts (1-$maxAttemptsLimit)",
                        ),
                        const SizedBox(height: 12),
                        _buildInputField(
                          _timeController,
                          "Time Limit in seconds (1-$maxTimeLimit)",
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: _startGame,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF85F5F),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(2, 4),
                                    blurRadius: 6,
                                  ),
                                ],
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
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            "Good Luck & Have Fun! 🎉",
                            style: GoogleFonts.irishGrover(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent.shade100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleRow(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.irishGrover(
                fontSize: 18,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.orangeAccent.shade100.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

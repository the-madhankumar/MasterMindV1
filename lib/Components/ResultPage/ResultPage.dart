import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Quote {
  final String quote;
  final String author;

  Quote({required this.quote, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['quote'] as String,
      author: json['author'] as String,
    );
  }
}

class Resultpage extends StatefulWidget {
  final List<int> secretCode;
  final bool cracked;
  final int timer;
  final int maxTime;

  const Resultpage({
    super.key,
    required this.secretCode,
    required this.cracked,
    required this.timer,
    required this.maxTime,
  });

  @override
  State<Resultpage> createState() => _ResultpageState();
}

class _ResultpageState extends State<Resultpage> {
  Quote? randomQuote;
  late int time;
  late int maxtime;

  @override
  void initState() {
    super.initState();
    time = widget.timer;
    maxtime = widget.maxTime;
    loadRandomQuote();
  }

  Future<void> loadRandomQuote() async {
    String jsonString = await rootBundle.loadString('assets/Data.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<dynamic> data = jsonData['quotes'];

    List<Quote> quotes = data.map((e) => Quote.fromJson(e)).toList();

    final randomIndex = Random().nextInt(quotes.length);

    setState(() {
      randomQuote = quotes[randomIndex];
    });
  }

  Color getColorFromCode(int code) {
    switch (code) {
      case 1:
        return Colors.redAccent.shade200;
      case 2:
        return Colors.blueAccent.shade200;
      case 3:
        return Colors.greenAccent.shade200;
      case 4:
        return Colors.orangeAccent.shade200;
      case 5:
        return Colors.purpleAccent.shade200;
      case 6:
        return Colors.yellowAccent.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  Widget buildSecretCodeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.secretCode.map((code) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: getColorFromCode(code),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(2, 3),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFB9223),
      body: Center(
        child: randomQuote == null
            ? const CircularProgressIndicator(color: Colors.white)
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.cracked
                          ? "Congratulations! You cracked it! 🔓"
                          : "Don't worry, try again next time! 💡",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Consumed Time: ${(maxtime - time).toStringAsFixed(2)} sec\n"
                      "⏳ Accuracy: ${((time / maxtime) * 100).toStringAsFixed(2)}% of consumed time",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Secret Code",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildSecretCodeRow(),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            randomQuote!.quote,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "- ${randomQuote!.author}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

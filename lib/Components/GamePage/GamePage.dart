import 'package:flutter/material.dart';
import 'package:mastermindv/Components/GamePage/Guess.dart';
import 'package:mastermindv/Components/ResultPage/ResultPage.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  final int maxAttempts;
  final int timeLimit;

  const GamePage({
    super.key,
    required this.maxAttempts,
    required this.timeLimit,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int count = 0;
  int blackCount = 1;
  int whiteCount = 0;
  late int maxAttempts;
  Timer? _timer;
  int remainingTime = 0;
  late int SetTime;

  final List<int> ColorCode = [1, 2, 3, 4, 5, 6];
  late List<int> SecretCode;

  List<Guess> guessHistory = [];
  int attempts = 0;

  List<int> currentGuess = [0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    SecretCode = (List<int>.from(ColorCode)..shuffle()).sublist(0, 4);
    print("Secret Code: $SecretCode");

    SetTime = widget.timeLimit;
    remainingTime = widget.timeLimit;
    maxAttempts = widget.maxAttempts;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Guess check(List<int> guessColors) {
    int blackCount = 0;
    int whiteCount = 0;

    for (int i = 0; i < 4; i++) {
      if (SecretCode.contains(guessColors[i])) {
        blackCount++;
      }
    }

    for (int i = 0; i < 4; i++) {
      if (guessColors[i] == SecretCode[i]) {
        whiteCount++;
      }
    }

    blackCount -= whiteCount;

    return Guess(
      color1: guessColors[0],
      color2: guessColors[1],
      color3: guessColors[2],
      color4: guessColors[3],
      blackCount: blackCount,
      whiteCount: whiteCount,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Resultpage(
                secretCode: SecretCode,
                cracked: false,
                timer: remainingTime,
                maxTime: SetTime,
              ),
            ),
          );
        }
      });
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4B975),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFB74D), Color(0xFFFB9223)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(150, 251, 146, 35),
                    offset: Offset(4, 4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Color.fromARGB(120, 0, 0, 0),
                    offset: Offset(-4, -4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Game Page",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 172, 210, 241),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Time Left: $remainingTime sec",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Attempts Left: ${maxAttempts - attempts}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            _InputContainer(
              const Color.fromARGB(152, 251, 114, 35),
              MainAxisAlignment.center,
              false,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: guessHistory.length,
                itemBuilder: (context, index) {
                  final item = guessHistory[index];
                  return _Container(
                    const Color.fromARGB(49, 251, 204, 35),
                    MainAxisAlignment.start,
                    true,
                    item,
                  );
                },
              ),
            ),

            const Divider(height: 20, indent: 0),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (!currentGuess.contains(0)) {
                    setState(() {
                      Guess toAdd = check(currentGuess);
                      guessHistory.add(toAdd);
                      currentGuess = [0, 0, 0, 0];
                      attempts += 1;
                    });

                    if (guessHistory.last.whiteCount == 4) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resultpage(
                            secretCode: SecretCode,
                            cracked: true,
                            timer: remainingTime,
                            maxTime: SetTime,
                          ),
                        ),
                      );
                      return;
                    }

                    if (attempts >= maxAttempts) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resultpage(
                            secretCode: SecretCode,
                            cracked: false,
                            timer: remainingTime,
                            maxTime: SetTime,
                          ),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF85F5F),
                  foregroundColor: Colors.white,
                  elevation: 15,
                  shadowColor: const Color.fromARGB(221, 234, 6, 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Guess',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Container(
    Color color,
    MainAxisAlignment algn,
    bool _result,
    Guess currentGuess,
  ) {
    final color1 = currentGuess.color1;
    final color2 = currentGuess.color2;
    final color3 = currentGuess.color3;
    final color4 = currentGuess.color4;
    final blackCount = currentGuess.blackCount;
    final whiteCount = currentGuess.whiteCount;

    return Container(
      color: const Color(0xFFF4B975),
      padding: EdgeInsets.all(10),
      child: Material(
        elevation: 10,
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: algn,
                    children: [
                      Row(
                        mainAxisAlignment: algn,
                        children: [
                          pegWith3DEffect(getColorFromCode(color1)),
                          const SizedBox(width: 8),
                          pegWith3DEffect(getColorFromCode(color2)),
                          const SizedBox(width: 8),
                          pegWith3DEffect(getColorFromCode(color3)),
                          const SizedBox(width: 8),
                          pegWith3DEffect(getColorFromCode(color4)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _result
                  ? resultContainer(blackCount, whiteCount)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _InputContainer(Color color, MainAxisAlignment algn, bool _result) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 15,
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: algn,
                  children: List.generate(4, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        child: ShapeCircle(getColorFromCode(currentGuess[i])),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => GetColors(i),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget GetColors(int index) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color.fromARGB(255, 240, 189, 133),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pick a Color",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.maxFinite,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: List.generate(6, (i) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(50),
                    splashColor: const Color(0xFFFB9223),
                    onTap: () {
                      setState(() {
                        currentGuess[index] = i + 1;
                      });
                      Navigator.of(context).pop();
                    },
                    child: ShapeCircle(getColorFromCode(i + 1)),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultContainer(int blackCount, int whiteCount) {
    List<Widget> pegs = [
      for (var i = 0; i < blackCount; i++) ShapeCircle(Colors.black, size: 12),
      for (var i = 0; i < whiteCount; i++) ShapeCircle(Colors.white, size: 12),
    ];

    while (pegs.length < 4) {
      pegs.add(Container(width: 12, height: 12));
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFB74D),
            const Color(0xFFFB9223),
          ], // subtle gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(150, 251, 146, 35),
            offset: Offset(4, 4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: const Color.fromARGB(120, 0, 0, 0),
            offset: Offset(-4, -4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [pegs[0], SizedBox(width: 4), pegs[1]],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [pegs[2], SizedBox(width: 4), pegs[3]],
          ),
        ],
      ),
    );
  }

  Widget pegWith3DEffect(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(1.0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            offset: Offset(3, 3),
            blurRadius: 4,
          ),
          BoxShadow(
            color: color.withOpacity(0.4),
            offset: Offset(-2, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(child: ShapeCircle(color)), // inner circle for depth
    );
  }

  Widget ShapeCircle(Color color, {double size = 40}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

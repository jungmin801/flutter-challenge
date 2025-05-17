import 'dart:async';
import 'package:flutter/material.dart';

class PomoTimer extends StatefulWidget {
  const PomoTimer({super.key});

  @override
  State<PomoTimer> createState() => _PomoTimerState();
}

class _PomoTimerState extends State<PomoTimer> {
  Timer? timer;
  List<int> secondsList = [900, 1200, 1500, 1800, 2100];
  int currentSeconds = 900;
  int totalSeconds = 900;
  bool isRunning = false;
  int round = 0;
  int goal = 0;
  bool isResting = false;
  bool restFinished = false;
  int restSeconds = 300;

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      timer.cancel();
      setState(() {
        isRunning = false;

        if (!isResting) {
          // 집중 세션 끝남
          round++;

          if (round == 1) {
            // 4회째 집중 세션 종료 → 휴식 시작
            isResting = true;
            totalSeconds = restSeconds;
            goal++;
          } else {
            // 아직 4회 안 됨 → 대기 상태
            totalSeconds = currentSeconds;
          }
        } else {
          // 휴식 끝남 → 다음 집중 준비
          isResting = false;
          round = 0; // 4번 집중 후 휴식 끝났으니 round 리셋
          totalSeconds = currentSeconds;
        }
      });
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onPausePressed() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onTap(int seconds) {
    timer?.cancel();
    setState(() {
      currentSeconds = seconds;
      totalSeconds = seconds;
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = currentSeconds;
    });
  }

  String formatMinutes(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 4);
  }

  String formatSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  'POMOTIMER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      if (isResting)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            '☕️ 휴식 중',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _FlipCard(number: formatMinutes(totalSeconds)),
                          const SizedBox(width: 8),
                          const Text(
                            ':',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _FlipCard(number: formatSeconds(totalSeconds)),
                        ],
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var second in secondsList)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: GestureDetector(
                              onTap: () => onTap(second),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      currentSeconds == second
                                          ? Colors.white
                                          : Colors.transparent,
                                  border: Border.all(
                                    color:
                                        currentSeconds == second
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                              255,
                                              255,
                                              255,
                                              0.6,
                                            ),
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  formatMinutes(second),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        currentSeconds == second
                                            ? Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor
                                            : const Color.fromRGBO(
                                              255,
                                              255,
                                              255,
                                              0.6,
                                            ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      IconButton(
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        iconSize: 100,
                        color: const Color.fromRGBO(0, 0, 0, 0.3),
                        icon: Icon(
                          isRunning
                              ? Icons.pause_circle
                              : Icons.play_circle_outline,
                        ),
                      ),
                      IconButton(
                        onPressed: onResetPressed,
                        iconSize: 34,
                        padding: EdgeInsets.zero,
                        color: const Color.fromRGBO(255, 255, 255, 0.5),
                        icon: const Icon(Icons.refresh_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$round/1',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'ROUND',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$goal/12',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'GOAL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlipCard extends StatelessWidget {
  final String number;

  const _FlipCard({required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // 중요! Positioned가 위로 나올 수 있게
      alignment: Alignment.center,
      children: [
        // 덧댄 종이 효과
        Positioned(
          top: -9,
          child: Container(
            width: 120,
            height: 88,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.45),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        Positioned(
          top: -5,
          child: Container(
            width: 130,
            height: 160,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.55),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        // 메인 카드
        Container(
          width: 140,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 86,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}

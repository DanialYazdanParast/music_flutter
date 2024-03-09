import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration? duration;
  Timer? timer;
  @override
  void initState() {
    audioPlayer.setAsset('assets/HaamimRazeShab.mp3').then((value) {
      duration = value;
      audioPlayer.play();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
      });
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: ExactAssetImage(
                        'assets/H.jpg',
                      ))),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: Colors.black26,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/haamim.jpg',
                              width: 80,
                            )),
                        const SizedBox(
                          width: 16,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Haamim',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '@ Haamim',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.heart,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 12, top: 24, bottom: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/H.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          Text(
                            'راز شب',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'حامیم',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    if (duration != null)
                      Slider(
                        inactiveColor: Colors.white12,
                        activeColor: Colors.white,
                        max: duration!.inMilliseconds.toDouble(),
                        value: audioPlayer.position.inMilliseconds.toDouble(),
                        onChangeStart: (value) {
                          audioPlayer.pause();
                        },
                        onChangeEnd: (value) {
                          audioPlayer.play();
                        },
                        onChanged: (value) {
                          audioPlayer
                              .seek(Duration(milliseconds: value.toInt()));
                        },
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _printDuration(audioPlayer.position),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          if (duration != null)
                            Text(
                              _printDuration(duration!),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                audioPlayer.seek(
                                  Duration(
                                      milliseconds:
                                          audioPlayer.position.inMilliseconds -
                                              10000),
                                );
                              });
                            },
                            icon: const Icon(
                              CupertinoIcons.backward_fill,
                              color: Colors.white,
                            )),
                        GestureDetector(
                          onTap: () {
                            if (audioPlayer.playing) {
                              audioPlayer.pause();
                            } else {
                              audioPlayer.play();
                            }
                          },
                          child: Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0x5574ff7e),
                                      blurRadius: 20,
                                      offset: Offset(0, 3))
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xff74ff7e),
                                      Color(0xff73c679),
                                    ]),
                              ),
                              child: Center(
                                  child: Icon(
                                audioPlayer.playing
                                    ? CupertinoIcons.pause
                                    : CupertinoIcons.play_fill,
                                color: Colors.white,
                                size: 32,
                              ))),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                audioPlayer.seek(Duration(
                                    milliseconds:
                                        audioPlayer.position.inMilliseconds +
                                            10000));
                              });
                            },
                            icon: const Icon(
                              CupertinoIcons.forward_fill,
                              color: Colors.white,
                            )),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign$twoDigitMinutes:$twoDigitSeconds";
  }
}

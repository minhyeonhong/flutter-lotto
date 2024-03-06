import 'package:flutter/material.dart';
import 'package:lotto/models/lotto.dart';
import 'dart:math';

import 'package:lotto/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<LottoModel>? lotto;
  bool isLoading = true;
  //랜덤 번호 만들기
  List<int> numbers = [];

  void generateRandomNumbers() {
    List<int> generatedNumbers = [];
    Random random = Random();

    while (generatedNumbers.length < 6) {
      int randomNumber = random.nextInt(45) + 1;
      if (!generatedNumbers.contains(randomNumber)) {
        generatedNumbers.add(randomNumber);
      }
    }

    setState(() {
      numbers = generatedNumbers;
    });
  }

  void waitForLottoNo() {
    setState(() {
      lotto = ApiService().getToDateNo();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    waitForLottoNo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FutureBuilder(
                            future: lotto,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  "[${snapshot.data!.drwtNo1},${snapshot.data!.drwtNo2},${snapshot.data!.drwtNo3},${snapshot.data!.drwtNo4},${snapshot.data!.drwtNo5},${snapshot.data!.drwtNo6} + bonus:${snapshot.data!.bnusNo}]",
                                  style: const TextStyle(
                                      fontSize: 30, color: Colors.black),
                                );
                              } else {
                                return const Text(
                                  "데이터 가져오는중...",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.black),
                                );
                              }
                            }),
                        const SizedBox(height: 20),
                        Text(
                          numbers.toString(),
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => generateRandomNumbers(),
                          child: const Text('로또 번호 줘'),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}

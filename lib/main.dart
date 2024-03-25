import 'package:flutter/material.dart';
import 'package:lotto/models/lotto.dart';
import 'dart:math';

import 'package:lotto/services/api_service.dart';
import 'package:lotto/widgets/lotto_calculate.dart';
import 'package:lotto/widgets/qr_scan_screen.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<LottoModel>? lotto, qr_lotto;
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

  // QR코드 스캔 결과를 받는 함수
  void handleScanResult(Future<LottoModel> result) {
    setState(() {
      qr_lotto = result;
    });
  }

  @override
  void initState() {
    super.initState();
    waitForLottoNo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder(
                        future: lotto,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data!.drwNo}회차 당첨번호\n[${snapshot.data!.drwtNo1},${snapshot.data!.drwtNo2},${snapshot.data!.drwtNo3},${snapshot.data!.drwtNo4},${snapshot.data!.drwtNo5},${snapshot.data!.drwtNo6} + bonus:${snapshot.data!.bnusNo}]",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            );
                          } else {
                            return const Text(
                              "데이터 가져오는중...",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            );
                          }
                        }),
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => QRScanScreen(
                                  handleScanResult: handleScanResult)),
                        ),
                      },
                      child: const Text('스캔 하기'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LottoCalculate()),
                        ),
                      },
                      child: const Text('로또상금 계산하기'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      numbers.toString(),
                      style: const TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => generateRandomNumbers(),
                      child: const Text('로또 번호 줘'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

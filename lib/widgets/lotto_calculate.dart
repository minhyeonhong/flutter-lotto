import 'package:flutter/material.dart';

class LottoCalculate extends StatefulWidget {
  const LottoCalculate({super.key});

  @override
  State<LottoCalculate> createState() => _LottoCalculateState();
}

class _LottoCalculateState extends State<LottoCalculate> {
  int input = 0, calculate1 = 0, calculate2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로또상금 계산'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "입력",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

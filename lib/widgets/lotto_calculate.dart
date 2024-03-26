import 'package:flutter/material.dart';

class LottoCalculate extends StatefulWidget {
  const LottoCalculate({super.key});

  @override
  State<LottoCalculate> createState() => _LottoCalculateState();
}

class _LottoCalculateState extends State<LottoCalculate> {
  final int lottoPrice = 1000, million2 = 2000000, million300 = 300000000;
  String _input = '0', _tax = '0', _result = '0';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _input = '0';
        _tax = '0';
        _result = '0';
      } else if (buttonText == 'Back') {
        // 입력값이 한 자리일 때는 '0'으로 설정
        _input =
            _input.length <= 1 ? '0' : _input.substring(0, _input.length - 1);
      } else {
        if (_input == '0') {
          _input = '';
        }
        _input += buttonText;
        _tax = _input;
        _result = _input;
      }

      try {
        double result = 0, tax = 0;
        double dTax = double.parse(_tax);
        if (million2 < dTax && dTax < million300) {
          // 22% 세금 계산
          tax = (dTax - lottoPrice) * 0.22;
          result = (dTax - lottoPrice) - tax;
        } else if (dTax > million300) {
          // 33% 세금 계산
          tax = (dTax - lottoPrice) * 0.33;
          result = (dTax - lottoPrice) - tax;
        } else {
          result = 0;
          tax = 0;
        }

        // 소수점 이하가 0이면 버림
        _tax = tax.toInt() == tax
            ? tax.toInt().toString()
            : tax.toStringAsFixed(2);
        _result = result.toInt() == result
            ? result.toInt().toString()
            : result.toStringAsFixed(2);
      } catch (e) {
        _tax = 'Error';
        _result = 'Error';
        _input = 'Error';
      }
    });
  }

  Widget _buildButton(String buttonText) {
    int color = 0xFF333333;
    int textColor = 0xFFFFFFFF;

    if (['AC', 'Back'].contains(buttonText)) {
      color = 0xFFFF9F0A;
    }

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(color)),
        shape: MaterialStateProperty.all(const CircleBorder()),
        fixedSize:
            MaterialStateProperty.all(const Size(80.0, 80.0)), // 원하는 크기로 조절
      ),
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: ['AC', 'Back'].contains(buttonText) ? 14 : 30,
          color: Color(textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('로또상금 계산'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Text(
                  "로또 당첨금 (2023월 1월 1일부터)\n3억 이상 : 세금 33%(소득세 30% + 주민세 3%)\n3억 미만 200만원 초과 : 세금 22%(소득세 20 % + 주민세 2%)\n200만원 이하 : 세금 없음",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "당첨금 : $_input",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "세금 : $_tax",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "세후 수령액 : $_result",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('7'),
                          _buildButton('8'),
                          _buildButton('9'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('4'),
                          _buildButton('5'),
                          _buildButton('6'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('1'),
                          _buildButton('2'),
                          _buildButton('3'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('0'),
                          _buildButton('AC'),
                          _buildButton('Back'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

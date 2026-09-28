import 'package:flutter/material.dart';
import 'package:lab8_bmicalculator/constants.dart';
import 'package:lab8_bmicalculator/components.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  });

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Kết quả của bạn',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              color: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    resultText,
                    style: const TextStyle(color: Color(0xFF24D876), fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    bmiResult,
                    style: const TextStyle(fontSize: 100.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'TÍNH LẠI',
            onTap: () {
              Navigator.pop(context); // Quay lại trang trước
            },
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        _result = _calculateResult();
        _input = '';
      } else if (value == 'C') {
        _input = '';
        _result = '';
      } else {
        _input += value;
      }
    });
  }

  String _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input.replaceAll('x', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  _input,
                  style: const TextStyle(color: Colors.white, fontSize: 36),
                ),
              ),
            ),
            Text(
              _result,
              style: const TextStyle(color: Colors.orange, fontSize: 48),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
                children: [
                  _buildCalculatorButton('7'),
                  _buildCalculatorButton('8'),
                  _buildCalculatorButton('9'),
                  _buildCalculatorButton('C'),
                  _buildCalculatorButton('4'),
                  _buildCalculatorButton('5'),
                  _buildCalculatorButton('6'),
                  _buildCalculatorButton('*'),
                  _buildCalculatorButton('1'),
                  _buildCalculatorButton('2'),
                  _buildCalculatorButton('3'),
                  _buildCalculatorButton('-'),
                  _buildCalculatorButton('0'),
                  _buildCalculatorButton('='),
                  _buildCalculatorButton('+'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          padding: const EdgeInsets.all(16), 
        ),
        onPressed: () => _onButtonPressed(value),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:konversi_satuan_panjang/kalkulator.dart';
class KonversiPanjangPage extends StatefulWidget {
  const KonversiPanjangPage({super.key});

  @override
  _KonversiPanjangPageState createState() => _KonversiPanjangPageState();
}

class _KonversiPanjangPageState extends State<KonversiPanjangPage> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'dm';
  String _toUnit = 'cm';
  double _result = 0.0;

  final List<String> _units = ['km', 'hm', 'dam', 'm', 'dm', 'cm', 'mm'];

  void _convert() {
    double value = double.tryParse(_inputController.text) ?? 0;
    setState(() {
      _result = _convertUnit(value, _fromUnit, _toUnit);
    });
  }

  double _convertUnit(double value, String from, String to) {
    Map<String, double> conversion = {
      'km': 1000000,
      'hm': 100000,
      'dam': 10000,
      'm': 1000,
      'dm': 100,
      'cm': 10,
      'mm': 1,
    };

    double fromFactor = conversion[from]!;
    double toFactor = conversion[to]!;
    return value * (fromFactor / toFactor);
  }

  void _goToCalculator() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CalculatorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Satuan Panjang'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: _goToCalculator,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai',
                labelStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  dropdownColor: Colors.grey[850],
                  value: _fromUnit,
                  items: _units.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(
                        unit,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value!;
                    });
                  },
                ),
                const Text(
                  'ke',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.grey[850],
                  value: _toUnit,
                  items: _units.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(
                        unit,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _convert,
              child: const Text(
                'Konversi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Hasil: $_result $_toUnit',
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

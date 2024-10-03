import 'package:flutter/material.dart';
import 'package:konversi_satuan_panjang/konversi.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KonversiPanjangPage()
    );
  }
}

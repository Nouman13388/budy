import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MobileScannerScreen(),
    );
  }
}

class MobileScannerScreen extends StatefulWidget {
  const MobileScannerScreen({Key? key}) : super(key: key);

  @override
  State<MobileScannerScreen> createState() => _MobileScannerScreenState();
}

class _MobileScannerScreenState extends State<MobileScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            // print('Barcode ${barcode.value} found at ${barcode.boundingBox}');
            print('Barcode ${barcode.rawValue}');
          }
          if (image != null) {
            print('Image captured with size ${image.lengthInBytes}');
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  barcodes.first.rawValue ?? "",
                ),
                content: Image.memory(image),
              ),
            );
          }
        },
      ),
    );
  }
}

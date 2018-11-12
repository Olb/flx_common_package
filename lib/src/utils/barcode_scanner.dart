import 'dart:async';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeScanner {
  static Future<String> scanImage() async {
    final File imageFile =
    await ImagePicker.pickImage(source: ImageSource.camera);

    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(imageFile);

    BarcodeDetector detector = FirebaseVision.instance.barcodeDetector();

    final List<Barcode> results = await detector.detectInImage(visionImage) ?? <dynamic>[];

    if (results == null || results.length == 0) {
      return null;
    }

    return results[0].rawValue;
  }
}

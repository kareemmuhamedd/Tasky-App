import 'dart:async';
import 'dart:isolate';
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

class ImageCompressionParams {
  final String imagePath;
  final SendPort sendPort;

  ImageCompressionParams(this.imagePath, this.sendPort);
}

/// The isolate entry point
void compressImageIsolate(ImageCompressionParams params) async {
  try {
    final compressedBytes = await compressImage(params.imagePath);
    params.sendPort.send(compressedBytes);
  } catch (error) {
    params.sendPort.send(error);
  }
}

/// Compression logic
Future<Uint8List> compressImage(String imagePath) async {
  final fileBytes = await File(imagePath).readAsBytes();
  final image = img.decodeImage(fileBytes);

  if (image == null) {
    throw Exception('Invalid image format.');
  }

  const maxSize = 100 * 1024; // 100 KB
  int quality = 100; // Start with the highest quality
  Uint8List compressedBytes;

  do {
    compressedBytes = Uint8List.fromList(img.encodeJpg(image, quality: quality));
    quality -= 10; // Reduce quality in steps to compress further
  } while (compressedBytes.length > maxSize && quality > 10);

  return compressedBytes;
}

/// Use Isolate for compression
Future<Uint8List> compressImageWithIsolate(String imagePath) async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    compressImageIsolate,
    ImageCompressionParams(imagePath, receivePort.sendPort),
  );

  // Wait for the result from the isolate
  final result = await receivePort.first;
  isolate.kill();

  if (result is Uint8List) {
    return result;
  } else if (result is Exception) {
    throw result;
  } else {
    throw Exception('Unknown error occurred during compression.');
  }
}

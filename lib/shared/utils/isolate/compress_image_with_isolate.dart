import 'dart:async';
import 'dart:isolate';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressionParams {
  final String imagePath;
  final int targetSizeKB;
  final SendPort sendPort;

  ImageCompressionParams(this.imagePath, this.targetSizeKB, this.sendPort);
}

/// Isolate Entry Point
void compressImageIsolate(ImageCompressionParams params) async {
  try {
    final compressedFile = await compressImage(
      filePath: params.imagePath,
      targetSizeKB: params.targetSizeKB,
    );
    params.sendPort.send(compressedFile);
  } catch (error) {
    params.sendPort.send(error);
  }
}

/// Compression Logic
Future<File?> compressImage({
  required String filePath,
  required int targetSizeKB,
}) async {
  final targetBytes = targetSizeKB * 1024;
  int quality = 95; /// Start with high quality

  File? compressedFile;

  do {
    final tempDir = await getTemporaryDirectory();
    final outputFilePath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outputFilePath,
      quality: quality,
      format: CompressFormat.jpeg,
    );

    if (compressedXFile == null) {
      throw Exception('Compression failed.');
    }

    compressedFile = File(compressedXFile.path); /// Convert XFile to File
    quality -= 5; /// Decrease quality in steps if size not achieved
  } while (compressedFile.lengthSync() > targetBytes && quality > 10);

  return compressedFile;
}
/// Compress Using Isolate
Future<File> compressImageWithIsolate(String imagePath, int targetSizeKB) async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    compressImageIsolate,
    ImageCompressionParams(imagePath, targetSizeKB, receivePort.sendPort),
  );

  // Wait for the result
  final result = await receivePort.first;
  isolate.kill();

  if (result is File) {
    return result;
  } else if (result is Exception) {
    throw result;
  } else {
    throw Exception('Unknown error occurred during compression.');
  }
}
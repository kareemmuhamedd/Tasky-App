import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart'; // For platform check

class ImageCompressionParams {
  final String imagePath;
  final SendPort sendPort;

  ImageCompressionParams(this.imagePath, this.sendPort);
}

/// The isolate entry point for desktop compression
void compressImageIsolate(ImageCompressionParams params) async {
  try {
    final compressedBytes =
        await compressImageWithImagePackage(params.imagePath);
    params.sendPort.send(compressedBytes);
  } catch (error) {
    params.sendPort.send(error);
  }
}

/// Compression using the `image` package (desktop)
Future<Uint8List> compressImageWithImagePackage(String imagePath) async {
  final fileBytes = await File(imagePath).readAsBytes();
  final image = img.decodeImage(fileBytes);

  if (image == null) {
    throw Exception('Invalid image format.');
  }

  const maxSize = 500 * 1024; // 500 KB
  int quality = 100; // Start with the highest quality
  Uint8List compressedBytes;

  do {
    compressedBytes =
        Uint8List.fromList(img.encodeJpg(image, quality: quality));
    quality -= 5; // Reduce quality gradually to preserve more detail
  } while (compressedBytes.length > maxSize && quality > 10);

  return compressedBytes;
}

/// Compression using `FlutterImageCompress` (mobile)
Future<File?> compressImageWithFlutterImageCompress({
  required String filePath,
  int targetSizeKB = 500,
}) async {
  final outputFilePath = path.join(
    Directory.systemTemp.path,
    'compressed_${path.basename(filePath)}',
  );

  int quality = 100;
  File? compressedFile;

  do {
    final compressedXFile = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outputFilePath,
      quality: quality,
      format: CompressFormat.jpeg,
    );

    if (compressedXFile == null) {
      throw Exception('Image compression failed.');
    }

    compressedFile = File(compressedXFile.path);

    quality -= 5;
  } while (compressedFile.lengthSync() > targetSizeKB * 1024 && quality > 10);

  return compressedFile;
}

/// Unified function to select compression method based on platform
Future<File?> compressImage({
  required String filePath,
  int targetSizeKB = 500,
}) async {
  if (kIsWeb) {
    throw UnsupportedError('Image compression is not supported on web.');
  }

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    // Use `image` package for desktop platforms
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      compressImageIsolate,
      ImageCompressionParams(filePath, receivePort.sendPort),
    );

    // Wait for the result from the isolate
    final result = await receivePort.first;
    isolate.kill();

    if (result is Uint8List) {
      final tempFile =
          File('${Directory.systemTemp.path}/compressed_image.jpg');
      await tempFile.writeAsBytes(result);
      return tempFile;
    } else if (result is Exception) {
      throw result;
    } else {
      throw Exception('Unknown error occurred during compression.');
    }
  } else {
    // Use `FlutterImageCompress` for mobile platforms
    return await compressImageWithFlutterImageCompress(
      filePath: filePath,
      targetSizeKB: targetSizeKB,
    );
  }
}

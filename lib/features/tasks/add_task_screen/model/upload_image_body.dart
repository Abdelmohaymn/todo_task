import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

class UploadImageBody {
  File image;

  UploadImageBody({required this.image});

  Future<FormData> toFormData() async {
    // Read the image file as bytes
    Uint8List imageBytes = await image.readAsBytes();

    // Use compute to process the image in a separate isolate
    List<int> compressedImage = await compute(compressImage, imageBytes);

    // Create a MultipartFile from the compressed image
    MultipartFile pic = MultipartFile.fromBytes(
      compressedImage,
      filename: image.path.split('/').last,
      contentType: MediaType('image', image.path.split('.').last.toLowerCase()),
    );

    // Create the FormData object
    Map<String, dynamic> json = {'image': pic};
    return FormData.fromMap(json);
  }
}

// Function to be run in a separate isolate
List<int> compressImage(Uint8List imageBytes) {
  // Decode the image for processing
  img.Image? originalImage = img.decodeImage(imageBytes);
  if (originalImage == null) {
    throw Exception('Failed to decode image');
  }

  // Resize and compress the image
  img.Image resizedImage = img.copyResize(originalImage, width: 800);
  return img.encodeJpg(resizedImage, quality: 85);
}

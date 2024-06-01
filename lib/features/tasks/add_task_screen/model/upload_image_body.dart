
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class UploadImageBody{
  File image;

  UploadImageBody({
    required this.image
  });

  Future<FormData> toFormData() async{
    //print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIii ${image.path.split('/').last}');
    MultipartFile pic = MultipartFile.fromBytes(
      await image.readAsBytes(),
      filename:image.path.split('/').last,
      contentType: MediaType('image', image.path.split('.').last.toLowerCase()),
    );
    Map<String, dynamic> json = {'image': pic};
    return FormData.fromMap(json);
  }

}
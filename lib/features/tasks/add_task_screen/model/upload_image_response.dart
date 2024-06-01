import 'package:json_annotation/json_annotation.dart';
part 'upload_image_response.g.dart';

@JsonSerializable()
class UploadImageResponse {
  UploadImageResponse({
      this.image,
  });


  String? image;

  factory UploadImageResponse.fromJson(Map<String,dynamic>json) => _$UploadImageResponseFromJson(json);

}
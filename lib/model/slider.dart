import 'dart:convert';

Slider sliderFromJson(String str) => Slider.fromJson(json.decode(str));

String sliderToJson(Slider data) => json.encode(data.toJson());

class Slider {
  Slider({
    required this.success,
    required this.message,
    required this.data,
  });

  bool? success;
  String? message;
  List<Datum> data;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data":
            data != null ? List<dynamic>.from(data.map((x) => x.toJson())) : [],
      };
}

class Datum {
  Datum({
    required this.id,
    required this.sliderImage,
    required this.sliderDescription,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? sliderImage;
  String? sliderDescription;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sliderImage: json["slider_image"],
        sliderDescription: json["slider_description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slider_image": sliderImage,
        "slider_description": sliderDescription,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

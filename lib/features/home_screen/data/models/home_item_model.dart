import 'package:hive/hive.dart';
import '../../domain/entities/home_item.dart';

part 'home_item_model.g.dart'; // مهم لإنشاء ملف التوليد

@HiveType(typeId: 0)
class HomeItemModel extends HomeItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String image;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? overlayText;

  const HomeItemModel({
    required this.id,
    required this.image,
    required this.name,
    this.overlayText,
  }) : super(id: id, image: image, name: name, overlayText: overlayText);

  factory HomeItemModel.fromJson(Map<String, dynamic> json) {
    return HomeItemModel(
      id: json['id'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      overlayText: json['overlayText'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      if (overlayText != null) 'overlayText': overlayText,
    };
  }
}

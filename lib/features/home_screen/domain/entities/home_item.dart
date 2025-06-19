import 'package:equatable/equatable.dart';

class HomeItem extends Equatable {
  final String id;
  final String image;
  final String name;
  final String? overlayText;

  const HomeItem({
    required this.id,
    required this.image,
    required this.name,
    this.overlayText,
  });

  @override
  List<Object?> get props => [id, image, name, overlayText];
}

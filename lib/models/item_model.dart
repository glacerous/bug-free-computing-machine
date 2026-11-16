import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel extends HiveObject {
  @HiveField(0)
  final int index;

  @HiveField(1)
  final String spell;

  @HiveField(2)
  final String use;

  ItemModel({
    required this.index,
    required this.spell,
    required this.use,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      index: json['index'] ?? 0,
      spell: json['spell'] ?? '',
      use: json['use'] ?? '',
    );
  }
}

class CharacterModel {
  final String fullName;
  final String nickname;
  final String hogwartsHouse;
  final String interpretedBy;
  final List<String> children;
  final String image;
  final String birthdate;
  final int index;

  CharacterModel({
    required this.fullName,
    required this.nickname,
    required this.hogwartsHouse,
    required this.interpretedBy,
    required this.children,
    required this.image,
    required this.birthdate,
    required this.index,
  });

    factory CharacterModel.fromJson(Map<String, dynamic> json) {
      return CharacterModel(
        fullName: json['fullName'] ?? '',
        nickname: json['nickname'] ?? '',
        hogwartsHouse: json['hogwartsHouse'] ?? '',
        interpretedBy: json['interpretedBy'] ?? '',
        children: List<String>.from(json['children'] ?? []),
        image: json['image'] ?? '',
        birthdate: json['birthdate'] ?? '',
        index: json['index'] ?? 0,
      );
  }
}
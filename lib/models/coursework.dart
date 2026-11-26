import 'package:json_annotation/json_annotation.dart';

part 'coursework.g.dart';

/// Coursework entry synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Coursework {
  const Coursework({
    this.id,
    required this.name,
    required this.category,
    required this.description,
    this.credits = 3,
    this.journal = '',
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Coursework.fromJson(Map<String, dynamic> json) =>
      _$CourseworkFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String name;
  final String category;
  final String description;

  @JsonKey(defaultValue: 3)
  final int credits;

  @JsonKey(defaultValue: '')
  final String journal;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$CourseworkToJson(this);
}

import '../../domain/entities/user_entity.dart';

/// Maps a row of the `profiles` table.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.budget,
    required super.totalPoints,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: (json['full_name'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      // Postgres `numeric` may arrive as int, double or string.
      budget: _toDouble(json['budget']),
      totalPoints: (json['total_points'] as num?)?.toInt() ?? 0,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      budget: entity.budget,
      totalPoints: entity.totalPoints,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'budget': budget,
      'total_points': totalPoints,
    };
  }

  static double _toDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}

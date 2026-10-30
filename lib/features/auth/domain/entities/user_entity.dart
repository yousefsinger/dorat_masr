import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.budget,
    required this.totalPoints,
  });

  final String id;
  final String fullName;
  final String email;

  /// Remaining fantasy budget (in millions).
  final double budget;
  final int totalPoints;

  @override
  List<Object?> get props => [id, fullName, email, budget, totalPoints];
}

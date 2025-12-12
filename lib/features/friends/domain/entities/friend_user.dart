import 'package:equatable/equatable.dart';

class FriendUser extends Equatable {
  final String id;
  final String email;
  final String? name;

  const FriendUser({required this.id, required this.email, this.name});

  @override
  List<Object?> get props => [id, email, name];
}

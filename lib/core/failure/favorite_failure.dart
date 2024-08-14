import 'package:equatable/equatable.dart';

class FavoriteFailure extends Equatable {
  final String message;

  const FavoriteFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

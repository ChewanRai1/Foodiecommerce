import 'package:equatable/equatable.dart';

class SearchFailure extends Equatable {
  final String message;

  const SearchFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
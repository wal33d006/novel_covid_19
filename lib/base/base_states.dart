import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {}

class BaseInitialState extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BaseErrorState extends BaseState {
  final String errorMessage;

  BaseErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
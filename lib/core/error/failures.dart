import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  @override
  final String message;
  const ServerFailure(this.message) : super(message: message);

}

class CacheFailure extends Failure {
  @override
  final String message;
  const CacheFailure(this.message) : super(message: message);
}

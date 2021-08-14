import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestFailure extends Failure {}

class DatabaseFailure extends Failure {}

class ConfigurationFailure extends Failure {}

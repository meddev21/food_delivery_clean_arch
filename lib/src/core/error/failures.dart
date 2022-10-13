import 'dart:io';
import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:food_delivery_clean_arch/src/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final String? statusText;
  final String? details;

  const Failure({
    this.statusCode,
    this.statusText,
    this.details,
  });

  @override
  String toString() {
    return "[$statusCode]: $statusText \n $details";
  }
  // TODO: Fix it on runtime 
  static Failure APIFailure(Exception exception){
    // SocketException a;
    //     if(exception is SocketException){
    //       return GlobalFailure();
    //     }
    //     switch (exception.runtimeType) {
    //       case SocketException:
    //           return OfflineFailure(details: exception.toString());
    //       case TimeoutException:
    //           return TimeOutFailure(exception.toString());
    //       case RequestException:
    //           return responseFailure(exception);
    //       default:
    //     }
    return const GlobalFailure('test');
  }
  
  
  static Failure responseFailure(RequestException exception) {
    switch (exception.statusCode) {
      case 400:
        return BadRequestFailure(exception.details);
      case 401:
      case 403:
        return UnauthorisedFailure(exception.details);
      case 404:
        return const BadRequestFailure('Not found');
      case 408:
        return TimeOutFailure(exception.details);
      case 500:
        return FetchDataFailure(exception.details);
      default:
        throw FetchDataFailure(
            'Error occured while Communication with Server with StatusCode : ${exception.statusCode}');
    }
  }
}

class OfflineFailure extends Failure {
  const OfflineFailure({String? details = 'Please Check your Internet Connection'})
      : super(
          statusText: "No-Internet",
          details: details,
        );

  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({String? details = 'No Data'})
      : super(
          statusText: "Server-Data",
          details: details,
        );

  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class FetchDataFailure extends Failure {
  const FetchDataFailure(String? details)
      : super(
          statusText: "Error During Communication",
          details: details,
        );

  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(String? details)
      : super(
          statusText: "Invalid Input",
          details: details,
        );

  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String? details)
      : super(
          statusText: "Authentication Failed",
          details: details,
        );
  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(String? details)
      : super(
          statusCode: 400,
          statusText: "Invalid Request",
          details: details,
        );

  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class UnauthorisedFailure extends Failure {
  const UnauthorisedFailure(String? details)
      : super(
          statusCode: 401,
          statusText: "Unauthorised",
          details: details,
        );

  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class TimeOutFailure extends Failure {
  const TimeOutFailure(String? details)
      : super(
          statusCode: 408,
          statusText: "Authentication Failed",
          details: details,
        );
  @override
  List<Object?> get props => [statusCode, statusText, details];
}

class GlobalFailure extends Failure {
  const GlobalFailure(String? details)
      : super(
          statusText: "GlobalFailure",
          details: details,
        );

  @override
  List<Object?> get props => [statusCode, statusText, details];
}

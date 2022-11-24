// import 'dart:io';

// import 'package:dio/dio.dart';
// abstract class NetworkExceptions  {
//   const factory NetworkExceptions.requestCancelled() =  RequestCancelled;

//   const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

//   const factory NetworkExceptions.badRequest() = BadRequest;

//   const factory NetworkExceptions.notFound(String reason) = NotFound;

//   const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

//   const factory NetworkExceptions.notAcceptable() = NotAcceptable;

//   const factory NetworkExceptions.requestTimeout() = RequestTimeout;

//   const factory NetworkExceptions.sendTimeout() = SendTimeout;

//   const factory NetworkExceptions.conflict() = Conflict;

//   const factory NetworkExceptions.internalServerError() = InternalServerError;

//   const factory NetworkExceptions.notImplemented() = NotImplemented;

//   const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

//   const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

//   const factory NetworkExceptions.formatException() = FormatException;

//   const factory NetworkExceptions.unableToProcess() = UnableToProcess;

//   const factory NetworkExceptions.defaultError(String error) = DefaultError;

//   const factory NetworkExceptions.unexpectedError() = UnexpectedError;

//   static NetworkExceptions getDioException(error) {
//     if (error is Exception) {
//       try {
//         NetworkExceptions networkExceptions;
//         if (error is DioError) {
//           switch (error.type) {
//             case   DioErrorType.CANCEL:
//               networkExceptions = NetworkExceptions.requestCancelled();
//               break;
//             case DioErrorType.CONNECT_TIMEOUT:
//               networkExceptions = NetworkExceptions.requestTimeout();
//               break;
//             case DioErrorType.DEFAULT:
//               networkExceptions = NetworkExceptions.noInternetConnection();
//               break;
//             case DioErrorType.RECEIVE_TIMEOUT:
//               networkExceptions = NetworkExceptions.sendTimeout();
//               break;
//             case DioErrorType.RESPONSE:
//               switch (error.response.statusCode) {
//                 case 400:
//                   networkExceptions = NetworkExceptions.unauthorisedRequest();
//                   break;
//                 case 401:
//                   networkExceptions = NetworkExceptions.unauthorisedRequest();
//                   break;
//                 case 403:
//                   networkExceptions = NetworkExceptions.unauthorisedRequest();
//                   break;
//                 case 404:
//                   networkExceptions = NetworkExceptions.notFound("Not found");
//                   break;
//                 case 409:
//                   networkExceptions = NetworkExceptions.conflict();
//                   break;
//                 case 408:
//                   networkExceptions = NetworkExceptions.requestTimeout();
//                   break;
//                 case 500:
//                   networkExceptions = NetworkExceptions.internalServerError();
//                   break;
//                 case 503:
//                   networkExceptions = NetworkExceptions.serviceUnavailable();
//                   break;
//                 default:
//                   var responseCode = error.response.statusCode;
//                   networkExceptions = NetworkExceptions.defaultError(
//                     "Received invalid status code: $responseCode",
//                   );
//               }
//               break;
//             case  DioErrorType.SEND_TIMEOUT:
//               networkExceptions = NetworkExceptions.sendTimeout();
//               break;
//           }
//         } else if (error is SocketException) {
//           networkExceptions = NetworkExceptions.noInternetConnection();
//         } else {
//           networkExceptions = NetworkExceptions.unexpectedError();
//         }
//         return networkExceptions;
//       } on FormatException catch (e) {
//         // Helper.printError(e.toString());
//         return NetworkExceptions.formatException();
//       } catch (_) {
//         return NetworkExceptions.unexpectedError();
//       }
//     } else {
//       if (error.toString().contains("is not a subtype of")) {
//         return NetworkExceptions.unableToProcess();
//       } else {
//         return NetworkExceptions.unexpectedError();
//       }
//     }
//   }

//   static String getErrorMessage(NetworkExceptions networkExceptions) {
//     var errorMessage = "";
//     networkExceptions.when(notImplemented: () {
//       errorMessage = "Not Implemented";
//     }, requestCancelled: () {
//       errorMessage = "Request Cancelled";
//     }, internalServerError: () {
//       errorMessage = "Internal Server Error";
//     }, notFound: (String reason) {
//       errorMessage = reason;
//     }, serviceUnavailable: () {
//       errorMessage = "Service unavailable";
//     }, methodNotAllowed: () {
//       errorMessage = "Method Allowed";
//     }, badRequest: () {
//       errorMessage = "Bad request";
//     }, unauthorisedRequest: () {
//       errorMessage = "Unauthorised request";
//     }, unexpectedError: () {
//       errorMessage = "Unexpected error occurred";
//     }, requestTimeout: () {
//       errorMessage = "Connection request timeout";
//     }, noInternetConnection: () {
//       errorMessage = "No internet connection";
//     }, conflict: () {
//       errorMessage = "Error due to a conflict";
//     }, sendTimeout: () {
//       errorMessage = "Send timeout in connection with API server";
//     }, unableToProcess: () {
//       errorMessage = "Unable to process the data";
//     }, defaultError: (String error) {
//       errorMessage = error;
//     }, formatException: () {
//       errorMessage = "Unexpected error occurred";
//     }, notAcceptable: () {
//       errorMessage = "Not acceptable";
//     });
//     return errorMessage;
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/view/screens/layout_screen.dart';
import 'dart:io';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'package:news/view/screens/home_screen.dart';

class DioException {
  
  static ErrorResult dioExceptionHandling({  DioErrorType exceptionType, Response response}) {
   
      switch (exceptionType  ) {
        case DioErrorType.connectTimeout:
          return ErrorResult(
              image: 'assets/image/fetch_data_error.png', message: 'connectTimeout'.tr());
        case DioErrorType.sendTimeout:
          return ErrorResult(
              image: 'assets/image/fetch_data_error.png', message: 'sendTimeout'.tr());
        case DioErrorType.receiveTimeout:
          return ErrorResult(
              image: 'assets/image/fetch_data_error.png', message: 'ReceiveTimeout'.tr());
        case DioErrorType.response:
          return returnResponse(response: response);
        case DioErrorType.cancel:
          return ErrorResult(
              image: 'assets/image/fetch_data_error.png', message: 'Request Cancelled'.tr());
                case DioErrorType.other:
                return ErrorResult(
              image: 'assets/image/socket_error.png', message: 'No Internet connection'.tr());
      }
  }
  }


abstract class ServerException {
  ErrorResult errorResult();
}

class BadRequestException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        message: 'badRequestException'.tr(), image: 'assets/image/bad_request_error.png');
  }
}

class UnauthorisedException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        message: 'unauthorisedException'.tr(), image: 'assets/image/unauthorised_error.png');
  }
}

class FetchDataException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        message: 'fetchDataException'.tr(), image: 'assets/image/fetch_data_error.png');
  }
}

ErrorResult returnResponse({Response response}) {
  switch (response.statusCode) {
    case 400:
      return BadRequestException().errorResult();
    case 401:
    case 403:
      return UnauthorisedException().errorResult();
    case 404:
    case 500:
    case 503:
    default:
      return FetchDataException().errorResult();
  }
}

class ErrorResult {
  final String image, message;
  const ErrorResult({this.image, this.message});
}

class BuildForErrorWidget extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  // // final String errorMessage;
  String errorResult;
  String image;

  // // final Future Function() refresh;

  BuildForErrorWidget({Key key, this.errorResult, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                // image ?? 'assets/images/bad_request_error.png',
                image,
                //  errorResult.
              height:50.h,
                  width: 50.h,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 10),
                child: Text(
                  errorResult,
                  // 'ERROR inTERNET',
                  //  'fetchDataException',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 22.0,
                    height: 1,
                  ),
                ),
              ),
SizedBox(

height: 3.h,
),
              ElevatedButton(
                        
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.blueGrey.shade900,
                            primary: Colors.blueAccent,
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 15, left: 50, right: 50),
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:  Text(
                            'Try Again'.tr(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => LayoutScreen ()));

                        
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class DioException {
//   DioException({this.context});
// BuildContext context;
//   static BuildErrorWidget dioExceptionHandling(
//       { DioErrorType exceptionType, Response response}) {
//     switch (exceptionType) {
//       case DioErrorType.connectTimeout:
//         return  BuildErrorWidget(
//           errorMessage: 'connectTimeout',
//         );
//       case DioErrorType.sendTimeout:
//         return BuildErrorWidget(
//            errorMessage: 'sendTimeout',
//         );
//       case DioErrorType.receiveTimeout:
//         return BuildErrorWidget(
//            errorMessage: 'receiveTimeout',
//         );
//       case DioErrorType.response:
//         return returnResponse(response: response);
//       case DioErrorType.cancel:
//         return BuildErrorWidget(
//            errorMessage: 'cancel',
//            );
//       case DioErrorType.other:
//         return BuildErrorWidget(
//            errorMessage: 'other',

//         );
//     }

//     // if(exceptionType==DioErrorType.connectTimeout){
//     //        Navigator.push(context, MaterialPageRoute(builder: (_) =>  BuildErrorWidget( errorMessage: 'connectTimeout',)));

//     // }
//   }
// }

// class BuildErrorWidget extends StatelessWidget {
//   final refreshKey = GlobalKey<RefreshIndicatorState>();
//   final String errorMessage;
//   // final Future Function() refresh;

//   BuildErrorWidget(
//       {Key key,this.errorMessage })
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Image.asset(
//                 //   image ?? 'assets/images/bad_request_error.png',
//                 //   height: 300.0,
//                 //   width: 300.0,
//                 //   fit: BoxFit.fill,
//                 // ),
//                 Text(
//                   errorMessage,
//               //  'fetchDataException',
//                   style: TextStyle(
//                     color: Theme.of(context).tabBarTheme.labelColor,
//                     fontSize: 22.0,
//                     height: 1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
    
//   }
// }
// abstract class ServerException {
//   BuildErrorWidget errorResult();
// }

// class BadRequestException extends ServerException {
//   @override
//    BuildErrorWidget errorResult() {
//     return  BuildErrorWidget();
// }
// }

// class UnauthorisedException extends ServerException {
//   @override
//    BuildErrorWidget errorResult() {
//     return  BuildErrorWidget();
//   }
// }

// class FetchDataException extends ServerException {
//   @override
//    BuildErrorWidget errorResult() {
//     return  BuildErrorWidget();
//   }
// }


// BuildErrorWidget returnResponse({Response response}) {
//   switch (response.statusCode) {
//     case 400:
//       return BuildErrorWidget(
//         errorMessage: ' ERRROR 400',
//       );
//     case 401:
//     case 403:
//       return BuildErrorWidget(
//         errorMessage: ' ERRROR 401',
//       );
//     case 404:
//     case 500:
//     case 503:
//     default:
//       return BuildErrorWidget(
//         errorMessage: ' ERRROR 500',
//       );
//   }
// }
// class ErrorResult{
//   final String image, message;
//   const ErrorResult({ this.image, this.message});
// }
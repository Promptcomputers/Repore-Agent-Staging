class HttpErrorStrings {
  static const String connectionTimeOutActive =
      'Unable to make connection at the moment this may be caused by an unstable network or connection to the server, please try again later.';

  static const String connectionTimeOutNotActive =
      'Looks like you have no active connection at the moment, please try again when you have an active connection.';

  static const String sendTimeOut =
      'Looks like you have an unstable network at the moment, please try again when network stabilizes.';

  static const String receiveTimeOut =
      'Unable to connect to server at the moment';

  static const String badResponse =
      'Unable to complete request at the moment. Please contact our customer care';

  static const String opeartionCancelled = 'Operation was cancelled';

  static const String defaultError =
      'Looks like you are not connected to any active network. Please connect and try again';

  static const String unknownError = 'Unknown error occurred';

  static const String unAuthorized = 'Username or Password is Incorrect';
}

Map<String, dynamic> badRequest(Error? error) => {
  "statusCode": 400,
  "body": error?.stackTrace.toString()
};
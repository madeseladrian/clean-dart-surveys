Map<String, dynamic> noContent() => {
  "statusCode": 204,
  "body": null
};

Map<String, dynamic> badRequest(Error? error) => {
  "statusCode": 400,
  "body": error?.stackTrace.toString()
};
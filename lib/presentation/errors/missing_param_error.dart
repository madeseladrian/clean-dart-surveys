class MissingParamError implements Error {
  final String paramName;

  MissingParamError(this.paramName);
  
  @override
  StackTrace? get stackTrace => StackTrace.fromString('Missing param: $paramName');
}
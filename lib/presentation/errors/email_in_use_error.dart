class EmailInUseError implements Error {  
  @override
  StackTrace? get stackTrace => StackTrace.fromString('The received email is already in use');
}
abstract class Failure{

}

class ServerFailure extends Failure{

}

class LocalFailure extends Failure{
  
  final String error;
  LocalFailure({required this.error});
}
import 'package:gremio_de_historias/data/login_screen/login_remote_implementation.dart';
import 'package:gremio_de_historias/domain/login_repository.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';

class LoginDataImplementation extends LoginRepository{

  final LoginRemoteImplementation _remoteImplementation;

  LoginDataImplementation({
    required LoginRemoteImplementation remoteImplementation
  }) : _remoteImplementation = remoteImplementation;

  @override
  Future<Member?> loginMember(String user, String pass) {
    return _remoteImplementation.loginMember(user, pass);
  }

}
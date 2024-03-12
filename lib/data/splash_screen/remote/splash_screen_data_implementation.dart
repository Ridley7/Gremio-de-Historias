import 'package:gremio_de_historias/data/splash_screen/splash_screen_remote_implementation.dart';
import 'package:gremio_de_historias/domain/splash_screen_repository.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';

class SplashScreenDataImplementation extends SplashScreenRepository{

  final SplashScreenRemoteImplementation _remoteImplementation;

  SplashScreenDataImplementation({
    required SplashScreenRemoteImplementation remoteImplementation
  }) : _remoteImplementation = remoteImplementation;

  @override
  Future<Member?> loginMember(String user, String pass) {
    return _remoteImplementation.loginMember(user, pass);
  }


}
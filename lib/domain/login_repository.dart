import 'package:gremio_de_historias/models/login_screen/member.dart';

abstract class LoginRepository{

  Future<Member?> loginMember(String user, String pass);
}
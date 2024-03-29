import 'package:gremio_de_historias/models/login_screen/member.dart';

abstract class MembersRepository{

  Future<List<Member>> getMembers();
  Future<Member?> loginMember(String user, String pass);

}
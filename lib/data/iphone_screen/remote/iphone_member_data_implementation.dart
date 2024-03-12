import 'package:gremio_de_historias/data/iphone_screen/iphone_member_remote_implementation.dart';
import 'package:gremio_de_historias/domain/members_repository.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';

class IphoneMemberDataImplementation extends MembersRepository{

  final IPhoneRemoteMemberImplementation _remoteImplementation;

  IphoneMemberDataImplementation({
    required IPhoneRemoteMemberImplementation remoteImplementation
  }) : _remoteImplementation = remoteImplementation;

  @override
  Future<List<Member>> getMembers() {
    // TODO: implement getMembers
    return _remoteImplementation.getMembers();
  }

  @override
  Future<Member?> loginMember(String user, String pass) {
    return _remoteImplementation.loginMember(user, pass);
  }

}
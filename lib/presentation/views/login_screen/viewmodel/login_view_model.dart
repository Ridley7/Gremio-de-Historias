import 'dart:async';

import 'package:gremio_de_historias/domain/members_repository.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';
import 'package:gremio_de_historias/presentation/base/base_view_model.dart';
import 'package:gremio_de_historias/models/resource_state.dart';

class LoginViewModel extends BaseViewModel{

  final MembersRepository _membersRepository = MembersRepository();
  final StreamController<ResourceState<Member>> loginMemberState = StreamController();

  /*
  LoginViewModel({
    required MembersRepository membersRepository
  }) : _membersRepository = membersRepository;

   */

  performLoginMember(String name, String pass){
    loginMemberState.add(ResourceState.loading());

    _membersRepository.loginMember(name, pass)
    .then((value) => loginMemberState.add(ResourceState.success(value)))
    .catchError((error) => loginMemberState.add(ResourceState.error(error)));
  }


  @override
  void dispose() {
    // TODO: implement dispose
    loginMemberState.close();
  }

}


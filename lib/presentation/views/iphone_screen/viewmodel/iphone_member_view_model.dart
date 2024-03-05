import 'dart:async';

import 'package:gremio_de_historias/domain/members_repository.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';
import 'package:gremio_de_historias/presentation/base/base_view_model.dart';
import 'package:gremio_de_historias/presentation/model/resource_state.dart';

class IPhoneMemberViewModel extends BaseViewModel{

  final MembersRepository _membersRepository = MembersRepository();
  final StreamController<ResourceState<List<Member>>> getIphoneMemberState = StreamController();

  //Aqui falta un constructor para meter di
  fetchMembers(){
    getIphoneMemberState.add(ResourceState.loading());

    _membersRepository.getMembers()
    .then((value) => getIphoneMemberState.add(ResourceState.success(value)))
    .catchError((error) => getIphoneMemberState.add(ResourceState.error(error)));
  }


  @override
  void dispose() {
    // TODO: implement dispose
    getIphoneMemberState.close();
  }

}
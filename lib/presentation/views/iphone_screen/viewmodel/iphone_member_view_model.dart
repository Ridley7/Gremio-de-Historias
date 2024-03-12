import 'dart:async';

import 'package:gremio_de_historias/domain/members_repository.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';
import 'package:gremio_de_historias/presentation/base/base_view_model.dart';
import 'package:gremio_de_historias/models/resource_state.dart';

class IPhoneMemberViewModel extends BaseViewModel {
  final MembersRepository _membersRepository;
  final StreamController<ResourceState<List<Member>>> getIphoneMemberState =
      StreamController();

  IPhoneMemberViewModel({
    required MembersRepository membersRepository
  }) : _membersRepository = membersRepository;

  //Aqui falta un constructor para meter di
  fetchMembers() {
    getIphoneMemberState.add(ResourceState.loading());

    _membersRepository
        .getMembers()
        .then((value) => getIphoneMemberState.add(ResourceState.success(value)))
        .catchError(
            (error) => getIphoneMemberState.add(ResourceState.error(error)));
  }

  @override
  void dispose() {
    getIphoneMemberState.close();
  }
}

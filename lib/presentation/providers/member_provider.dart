import 'package:flutter/cupertino.dart';
import 'package:gremio_de_historias/presentation/models/login_screen/member.dart';

class MemberProvider with ChangeNotifier{
  late Member _currentMember;

  Member getCurrentMember(){
    return _currentMember;
  }

  void setCurrentMember(Member member){
    _currentMember = member;
  }

}
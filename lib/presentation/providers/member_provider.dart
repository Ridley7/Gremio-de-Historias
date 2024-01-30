import 'package:flutter/cupertino.dart';
import 'package:gremio_de_historias/presentation/models/login_screen/member.dart';

class MemberProvider with ChangeNotifier{
  late Member currentMember;

  Member getCurrentMember(){
    return currentMember;
  }

  void setCurrentMember(Member member){
    currentMember = member;
  }

}
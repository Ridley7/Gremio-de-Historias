import 'package:flutter/cupertino.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';

class ProxyMemberProvider with ChangeNotifier{
  late Member _proxyMember;

  Member getProxyMember(){
    return _proxyMember;
  }

  void setProxyMember(Member member){
    _proxyMember = member;
  }
}
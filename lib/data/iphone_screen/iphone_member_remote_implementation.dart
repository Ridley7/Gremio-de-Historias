import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gremio_de_historias/data/remote/error/remote_error_mapper.dart';
import 'package:gremio_de_historias/data/remote/network_client.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';

class IPhoneRemoteMemberImplementation{
  final NetworkClient _networkClient;

  IPhoneRemoteMemberImplementation({
    required NetworkClient networkClient
  }) : _networkClient = networkClient;

  Future<List<Member>> getMembers() async{
    try{
      QuerySnapshot querySnapshot = await _networkClient.db.collection(("members")).get();

      return querySnapshot.docs.map((member) => Member.fromJson(member.data() as Map<String, dynamic>)).toList();
    }catch (error){
      throw RemoteErrorMapper.getException(error);
    }
  }

  Future<Member?> loginMember(String user, String pass) async{

    //Obtenemos todos los miembros de la BD
    final data = await _networkClient.db.collection("members")
        .where("name", isEqualTo: user)
        .where("password", isEqualTo: pass)
        .get();

    Member? miembro;

    data.docs.forEach((document) {
      miembro = Member.fromJson(document.data() as Map<String, dynamic>);
    });

    return miembro;

  }

}
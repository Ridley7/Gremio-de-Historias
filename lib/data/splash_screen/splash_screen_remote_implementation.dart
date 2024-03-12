import 'package:gremio_de_historias/data/remote/error/remote_error_mapper.dart';
import 'package:gremio_de_historias/data/remote/network_client.dart';
import 'package:gremio_de_historias/models/login_screen/member.dart';

class SplashScreenRemoteImplementation{

  final NetworkClient _networkClient;

  SplashScreenRemoteImplementation({
    required NetworkClient networkClient
  }) : _networkClient = networkClient;

  Future<Member?> loginMember(String user, String pass) async{

   try{
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
   }catch(error){
     throw RemoteErrorMapper.getException(error);
   }

  }

}
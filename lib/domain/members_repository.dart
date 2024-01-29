

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gremio_de_historias/presentation/models/login_screen/member.dart';

class MembersRepository{

  Future<Member?> loginMember(String user, String pass) async{

    //Obtenemos todos los miembros de la BD
    FirebaseFirestore db = FirebaseFirestore.instance;
    //final data = await db.collection("members").get();
    final data = await db.collection("members")
    .where("name", isEqualTo: user)
    .where("password", isEqualTo: pass)
    .get();

    Member? miembro;

    data.docs.forEach((document) {
      miembro = Member.fromJson(document.data() as Map<String, dynamic>);
    });

    return miembro;

    /*
    if(miembro != null){
      print("El rol es: " + miembro!.role);

      //Aqui habria que devolver un miembro, fuera se compara si es null o no es null

    }else{
      print("No hay nadie asi");
    }
     */

  }

  /*
  Future<List<BoardGame>> getBoardGames() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = await db.collection("boardgames").get();

    List<BoardGame> boardgames = data.docs.map((boardgame) => BoardGame.fromJson(boardgame.data())).toList();
    return boardgames;
  }

   */

}
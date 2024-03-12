import 'package:cloud_firestore/cloud_firestore.dart';

class NetworkClient{
  final FirebaseFirestore db = FirebaseFirestore.instance;

}

/*
class NetworkClient{
  final Dio dio = Dio();

  NetworkClient(){
    dio.interceptors.add(LogInterceptor(
        logPrint: (log) => debugPrint(log.toString()),
        requestBody: true,
        responseBody: true
    ));
  }

}
 */
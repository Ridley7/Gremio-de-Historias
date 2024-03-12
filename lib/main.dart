import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gremio_de_historias/di/app_modules.dart';
import 'package:gremio_de_historias/firebase_options.dart';
import 'package:gremio_de_historias/presentation/providers/member_provider.dart';
import 'package:gremio_de_historias/presentation/providers/proxy_member_provider.dart';
import 'package:provider/provider.dart';
import 'presentation/navigation/navigation_routes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  AppModules().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MemberProvider>(create: (_) => MemberProvider()),
        ChangeNotifierProvider<ProxyMemberProvider>(create: (_) => ProxyMemberProvider())
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        localizationsDelegates: const[
          GlobalMaterialLocalizations.delegate
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        )
      ),
    );
  }
}

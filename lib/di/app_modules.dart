import 'package:get_it/get_it.dart';
import 'package:gremio_de_historias/data/iphone_screen/iphone_drop_game_remote_implementation.dart';
import 'package:gremio_de_historias/data/iphone_screen/iphone_games_screen_remote_implementation.dart';
import 'package:gremio_de_historias/data/iphone_screen/iphone_member_remote_implementation.dart';
import 'package:gremio_de_historias/data/iphone_screen/remote/iphone_drop_game_data_implementation.dart';
import 'package:gremio_de_historias/data/iphone_screen/remote/iphone_games_screen_data_implementation.dart';
import 'package:gremio_de_historias/data/iphone_screen/remote/iphone_member_data_implementation.dart';
import 'package:gremio_de_historias/data/lent_games_screen/lent_games_remote_implementation.dart';
import 'package:gremio_de_historias/data/lent_games_screen/remote/lent_games_data_implementation.dart';
import 'package:gremio_de_historias/data/login_screen/login_remote_implementation.dart';
import 'package:gremio_de_historias/data/login_screen/remote/login_data_implementation.dart';
import 'package:gremio_de_historias/data/own_games_screen/own_games_remote_implementation.dart';
import 'package:gremio_de_historias/data/own_games_screen/remote/own_games_data_implementation.dart';
import 'package:gremio_de_historias/data/remote/network_client.dart';
import 'package:gremio_de_historias/data/splash_screen/remote/splash_screen_data_implementation.dart';
import 'package:gremio_de_historias/data/splash_screen/splash_screen_remote_implementation.dart';
import 'package:gremio_de_historias/domain/boardgames_repository.dart';
import 'package:gremio_de_historias/domain/iphone_drop_game_repository.dart';
import 'package:gremio_de_historias/domain/iphone_game_screen_repository.dart';
import 'package:gremio_de_historias/domain/login_repository.dart';
import 'package:gremio_de_historias/domain/members_repository.dart';
import 'package:gremio_de_historias/domain/own_games_repository.dart';
import 'package:gremio_de_historias/domain/splash_screen_repository.dart';
import 'package:gremio_de_historias/presentation/views/common_model_view/drop_game_view_model.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/viewmodel/iphone_game_view_model.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/viewmodel/iphone_member_view_model.dart';
import 'package:gremio_de_historias/presentation/views/lent_games_screen/viewmodel/lent_game_view_model.dart';
import 'package:gremio_de_historias/presentation/views/login_screen/viewmodel/login_view_model.dart';

final inject = GetIt.instance;

class AppModules{
  setup(){
    _setupMainModule();
    _setupIphoneGameScreen();
    _setupIphoneMemberScreen();
    _setupIphoneDropGameScreen();
    _setupLentGameScreen();
    _setupLoginScreen();
    _setupSplashScreen();
    _setupOwnGamesScreen();
  }

  _setupIphoneGameScreen(){
    inject.registerFactory(() => IPhoneGamesScreenRemoteImplementation(networkClient: inject.get()));
    inject.registerFactory<IPhoneGameScreenRepository>(() => IPhoneGamesScreenDataImplementation(remoteImplementation: inject.get()));
    inject.registerFactory(() => IPhoneGameViewModel(boardgamesRepository: inject.get()));
  }

  _setupIphoneMemberScreen(){
    inject.registerFactory(() => IPhoneRemoteMemberImplementation(networkClient: inject.get()));
    inject.registerFactory<MembersRepository>(() => IphoneMemberDataImplementation(remoteImplementation: inject.get()));
    inject.registerFactory(() => IPhoneMemberViewModel(membersRepository: inject.get()));
  }

  _setupIphoneDropGameScreen(){
    inject.registerFactory(() => IphoneDropGameRemoteImplementation(networkClient: inject.get()));
    inject.registerFactory<IPhoneDropGameRepository>(() => IphoneDropGameDataImplementation(remoteImplementation: inject.get()));
    inject.registerFactory(() => DropGameModelView(boardgamesRepository: inject.get()));
  }

  _setupLentGameScreen(){
    inject.registerFactory(() => LentGamesRemoteImplementation(networkClient: inject.get()));
    inject.registerFactory<BoardgameRepository>(() => LentGamesDataImplementation(remoteImplementation: inject.get()));
    inject.registerFactory(() => LentGameViewModel(boardgamesRepository: inject.get()));
  }

  _setupLoginScreen(){
    inject.registerFactory(() => LoginRemoteImplementation(networkClient: inject.get()));
    inject.registerFactory<LoginRepository>(() => LoginDataImplementation(remoteImplementation: inject.get()));
    inject.registerFactory(() => LoginViewModel(membersRepository: inject.get()));
  }
  
  _setupSplashScreen(){
    inject.registerFactory(() => SplashScreenRemoteImplementation(networkClient: inject.get()));
    inject.registerFactory<SplashScreenRepository>(() => SplashScreenDataImplementation(remoteImplementation: inject.get()));
    //inject.registerFactory(() => LoginViewModel(membersRepository: inject.get()));
  }

  _setupOwnGamesScreen(){
    inject.registerFactory(() => OwnGamesRemoteImplementation(networkClient: inject.get()));
    inject.registerFactory<OwnGamesRepository>(() => OwnGamesDataImplementation(remoteImplementation: inject.get()));
    //inject.registerFactory(() => DropGameModelView(boardgamesRepository: inject.get()));
  }

  _setupMainModule(){
    inject.registerSingleton(NetworkClient());
  }


}


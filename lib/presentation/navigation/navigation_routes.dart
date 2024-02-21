
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/presentation/models/lent_game_screen/board_game.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/iphone_game_screen.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/iphone_member_screen.dart';
import 'package:gremio_de_historias/presentation/views/iphone_screen/iphone_menu_screen.dart';
import 'package:gremio_de_historias/presentation/views/lent_games_screen/lent_games_screen.dart';
import 'package:gremio_de_historias/presentation/views/lent_games_screen/boardgame_detail.dart';
import 'package:gremio_de_historias/presentation/views/login_screen/login_screen.dart';
import 'package:gremio_de_historias/presentation/views/main_menu_screen.dart';
import 'package:gremio_de_historias/presentation/views/own_games_screen.dart';
import 'package:gremio_de_historias/presentation/views/splash_screen.dart';

class NavigationRoutes{
  static const INITIAL_ROUTE = "/";
  static const String MAIN_MENU_ROUTE = "/mainmenu";
  static const String LOGIN_ROUTE = "/login";
  static const String LENT_SCREEN_ROUTE = "/lent";
  static const String BOARDGAME_DETAIL_ROUTE = "$LENT_SCREEN_ROUTE/$_BOARDGAME_DETAIL_PATH";
  static const String OWNGAMES_SCREEN_ROUTE = "/owngames";
  static const String IPHONE_SCREEN_ROUTE = "/iphone";
  static const String IPHONE_SCREEN_BOARDGAME_ROUTE = "$IPHONE_SCREEN_MENU_ROUTE/$_IPHONE_BOARDGAME_PATH";
  static const String IPHONE_SCREEN_DROP_BOARDGAME_ROUTE = "$IPHONE_SCREEN_MENU_ROUTE/$_IPHONE_DROP_BOARDGAME_PATH";
  static const String IPHONE_SCREEN_MENU_ROUTE = "$IPHONE_SCREEN_ROUTE/$_IPHONE_MENU_PATH";
  static const String IPHONE_SCREEN_BOARDGAME_DETAIL_ROUTE = "$IPHONE_SCREEN_BOARDGAME_ROUTE/$_IPHONE_BOARDGAME_DETAIL_PATH";


  static const String _BOARDGAME_DETAIL_PATH = "boardgame_detail";
  static const String _IPHONE_BOARDGAME_PATH = "iphone_boardgame";
  static const String _IPHONE_MENU_PATH = "iphone_menu";
  static const String _IPHONE_BOARDGAME_DETAIL_PATH = "iphone_boardgame_detail_path";
  static const String _IPHONE_DROP_BOARDGAME_PATH = "iphone_drop_boardgame_path";
}

final GoRouter router = GoRouter(
  initialLocation: NavigationRoutes.INITIAL_ROUTE,
    routes: [
      GoRoute(
          path: NavigationRoutes.INITIAL_ROUTE,
        builder: (context, state) => const SplashScreen()
      ),

      GoRoute(
          path: NavigationRoutes.LOGIN_ROUTE,
          builder: (context, state) => const LoginScreen()
      ),

      GoRoute(
        path: NavigationRoutes.MAIN_MENU_ROUTE,
        builder: (context, state) => MainMenuScreen()
      ),

      GoRoute(
          path: NavigationRoutes.LENT_SCREEN_ROUTE,
        builder: (context, state) => const LentGamesScreen(),
        routes: [
          GoRoute(
              path: NavigationRoutes._BOARDGAME_DETAIL_PATH,
            builder: (context, state) => BoardGameDetail(
              boardGame: state.extra as BoardGame,
            )
          )
        ]
      ),


      GoRoute(
          path: NavigationRoutes.OWNGAMES_SCREEN_ROUTE,
        builder: (context, state) => const OwnGamesScreen()
      ),

      GoRoute(
          path: NavigationRoutes.IPHONE_SCREEN_ROUTE,
          builder: (context, state) => const IphoneMemberScreen(),
        routes: [
          GoRoute(
              path: NavigationRoutes._IPHONE_MENU_PATH,
            builder: (context, state) => IPhoneMenuScreen(),
              routes: [
                //Ruta para prestar juego
                GoRoute(
                  path: NavigationRoutes._IPHONE_BOARDGAME_PATH,
                  builder: (context, state) => const IPhoneGameScreen(),
                  routes: [
                    //Detalle de juego
                    GoRoute(
                        path: NavigationRoutes._IPHONE_BOARDGAME_DETAIL_PATH,
                      builder: (context, state) => BoardGameDetail(
                          boardGame: state.extra as BoardGame
                      )
                    )
                  ]
                ),

                //Ruta para devolver juego
                /*
                GoRoute(
                  path: NavigationRoutes._IPHONE_DROP_BOARDGAME_PATH,
                  builder: (context, state) => const IPhoneDropGameScreen()
                )

                 */
      
              ]

          )
        ]
      ),

    ]
);
import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/presentation/views/lent_games_screen.dart';
import 'package:gremio_de_historias/presentation/views/lent_games_screen/boardgame_detail.dart';
import 'package:gremio_de_historias/presentation/views/main_menu_screen.dart';

class NavigationRoutes{
  static const INITIAL_ROUTE = "/";
  static const String LENT_SCREEN_ROUTE = "/lent";
  static const String BOARDGAME_DETAIL_ROUTE = "$LENT_SCREEN_ROUTE/$_BOARDGAME_DETAIL_PATH";

  static const String _BOARDGAME_DETAIL_PATH = "boardgame_detail";
}

final GoRouter router = GoRouter(
  initialLocation: NavigationRoutes.INITIAL_ROUTE,
    routes: [
      GoRoute(
          path: NavigationRoutes.INITIAL_ROUTE,
        builder: (context, state) => MainMenuScreen()
      ),

      GoRoute(
          path: NavigationRoutes.LENT_SCREEN_ROUTE,
        builder: (context, state) => const LentGamesScreen(),
        routes: [
          GoRoute(
              path: NavigationRoutes._BOARDGAME_DETAIL_PATH,
            builder: (context, state) => const BoardGameDetail()
          )
        ]
      ),
    ]
);
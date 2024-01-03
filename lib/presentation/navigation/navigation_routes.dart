import 'package:go_router/go_router.dart';
import 'package:gremio_de_historias/presentation/views/main_menu.dart';

class NavigationRoutes{
  static const INITIAL_ROUTE = "/";
}

final GoRouter router = GoRouter(
  initialLocation: NavigationRoutes.INITIAL_ROUTE,
    routes: [
      GoRoute(
          path: NavigationRoutes.INITIAL_ROUTE,
        builder: (context, state) => MainMenu()
      )
    ]
);
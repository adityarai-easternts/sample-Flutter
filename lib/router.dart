part of 'main_common.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'main',
      path: '/',
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      name: 'todo-details',
      path: '/todo-details/:todo',
      builder: (context, state) => DetailsScreenAppGoRouter(
        todo: state.extra as Todo,
      ),
    ),
    GoRoute(
      name: 'todo',
      path: '/todo',
      builder: (context, state) => NavigationDemoApp(),
    ),
    GoRoute(
      path: '/http-demo',
      name: 'http-demo',
      builder: (context, state) => MyHttpDemo(),
    )
  ],
);

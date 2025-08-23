part of 'part_of_import.dart';




class RouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: RouteName.teamSelectionScreen,

    routes: [
      //Bottom NavBar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomBarWidget(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.roosterViewScreen,
                pageBuilder: (context, state) {
                  return buildPageWithTransition(
                    context: context,
                    state: state,
                    transitionType: PageTransitionType.slideRightToLeft,
                    child: RoosterViewScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.matchdayScreen,
                builder: (context, state) => const MatchDayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.srTopTenScreen,
                builder: (context, state) => const SrTopTenScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.importExportScreen,
                builder: (context, state) => const ImportExportScreen(),
              ),
            ],
          ),
         
        ],
      ),

      GoRoute(
        name: RouteName.addPlayerScreen,
        path: RouteName.addPlayerScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: AddPlayerScreen());
        },
      ),
    GoRoute(
        name: RouteName.teamSelectionScreen,
        path: RouteName.teamSelectionScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: TeamSelectionScreen());
        },
      ),



       GoRoute(
        name: RouteName.historyScreen,
        path: RouteName.historyScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HistoryScreen());
        },
      ),
//       GoRoute(
//         name: RouteName.paymentSelection,
//         path: RouteName.paymentSelection,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: PaymentSelection());
//         },
//       ),
//       GoRoute(
//         name: RouteName.paymentIntro,
//         path: RouteName.paymentIntro,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: PaymentIntroScreen());
//         },
//       ),
//  GoRoute(
//         name: RouteName.signInScreen,
//         path: RouteName.signInScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: SignInScreen());
//         },
//       ),
//        GoRoute(
//         name: RouteName.acountCreatedScreen,
//         path: RouteName.acountCreatedScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: AcountCreatedScreen());
//         },
//       ),
//           GoRoute(
//         name: RouteName.forgetPasScreen,
//         path: RouteName.forgetPasScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: ForgetPasScreen());
//         },
//       ),
//        GoRoute(
//         name: RouteName.signupIntroScreen,
//         path: RouteName.signupIntroScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: SignupIntroScreen());
//         },),
//        GoRoute(
//         name: RouteName.successScreen,
//         path: RouteName.successScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: SuccessScreen());
//         },
//       ),
//        GoRoute(
//         name: RouteName.forgetOtpScreen,
//         path: RouteName.forgetOtpScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: ForgetOtpScreen());
//         },
//       ),
//        GoRoute(
//         name: RouteName.resetPassScreen,
//         path: RouteName.resetPassScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: ResetPassScreen());
//         },
//       ),
//        GoRoute(
//         name: RouteName.signupScreen,
//         path: RouteName.signupScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(child: SignupScreen());
//         },
//       ),

      // GoRoute(
      //   name: RouteName.ebookPlay,
      //   path: '${RouteName.ebookPlay}/:ebookId',
      //   pageBuilder: (context, state) {
      //     final ebookId = state.pathParameters['ebookId']!;
      //     return buildPageWithTransition(
      //       context: context,
      //       state: state,
      //       transitionType: PageTransitionType.fade,
      //       child: EbookPlay(ebookId: ebookId),
      //     );
      //   },
      // ),
    ]);

}

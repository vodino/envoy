import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'screen/_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runAssets();
  await runService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      routes: [
        GoRoute(
          path: HomeScreen.path,
          name: HomeScreen.name,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: CustomKeepAlive(
                child: HomeScreen(),
              ),
            );
          },
          routes: [
            GoRoute(
              path: AccountScreen.path,
              name: AccountScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: AccountScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: AuthScreen.path,
              name: AuthScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: AuthScreen(),
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: AuthVerificationScreen.path,
                  name: AuthVerificationScreen.name,
                  pageBuilder: (context, state) {
                    return const CupertinoPage(
                      child: CustomKeepAlive(
                        child: AuthVerificationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: OrderRecordingScreen.path,
              name: OrderRecordingScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: OrderRecordingScreen(),
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: OrderDeliveriedScreen.path,
                  name: OrderDeliveriedScreen.name,
                  pageBuilder: (context, state) {
                    return const CupertinoPage(
                      child: CustomKeepAlive(
                        child: OrderDeliveriedScreen(),
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: OrderFeedbackScreen.path,
                  name: OrderFeedbackScreen.name,
                  pageBuilder: (context, state) {
                    return const CupertinoPage(
                      child: CustomKeepAlive(
                        child: OrderFeedbackScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: DiscountScreen.path,
              name: DiscountScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: DiscountScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: BusinessScreen.path,
              name: BusinessScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: BusinessScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: HelpFaqScreen.path,
              name: HelpFaqScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: HelpFaqScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: SettingsScreen.path,
              name: SettingsScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: Themes.theme,
      themeMode: ThemeMode.light,
      darkTheme: Themes.darkTheme,
      color: Themes.primaryColor,
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      scrollBehavior: const CustomScrollBehavior(),
      supportedLocales: CustomBuildContext.supportedLocales,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      localizationsDelegates: CustomBuildContext.localizationsDelegates,
    );
  }
}

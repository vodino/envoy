import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screen/_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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
  /// Customer
  late final GoRouter _router;

  /// LocaleService
  late final LocaleService _localeService;

  @override
  void initState() {
    super.initState();

    /// Customer
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
          redirect: (context, state) {
            if (state.location == HomeScreen.path) return null;
            return ClientService.authenticated != null ? null : AuthScreen.path;
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
                  path: OrderContentScreen.path,
                  name: OrderContentScreen.name,
                  pageBuilder: (context, state) {
                    final order = state.extra as Order;
                    return CupertinoPage(
                      child: CustomKeepAlive(
                        child: OrderContentScreen(order: order),
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: OrderFeedbackScreen.path,
                  name: OrderFeedbackScreen.name,
                  pageBuilder: (context, state) {
                    final order = state.extra as Order;
                    return CupertinoPage(
                      child: CustomKeepAlive(
                        child: OrderFeedbackScreen(order: order),
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
              routes: [
                GoRoute(
                  path: SettingsLanguageScreen.path,
                  name: SettingsLanguageScreen.name,
                  pageBuilder: (context, state) {
                    return const CupertinoPage(
                      child: CustomKeepAlive(
                        child: SettingsLanguageScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
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
                final data = (state.extra as Map<String, dynamic>);
                return CupertinoPage(
                  child: CustomKeepAlive(
                    child: AuthVerificationScreen(
                      verificationId: data[AuthVerificationScreen.verificationIdKey],
                      phoneNumber: data[AuthVerificationScreen.phoneNumberKey],
                      resendToken: data[AuthVerificationScreen.resendTokenKey],
                      timeout: data[AuthVerificationScreen.timeoutKey],
                    ),
                  ),
                );
              },
            ),
            GoRoute(
              path: AuthSignupScreen.path,
              name: AuthSignupScreen.name,
              pageBuilder: (context, state) {
                final data = (state.extra as Map<String, dynamic>);
                return CupertinoPage(
                  child: CustomKeepAlive(
                    child: AuthSignupScreen(
                      phoneNumber: data[AuthSignupScreen.phoneNumberKey],
                      token: data[AuthSignupScreen.tokenKey],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );

    /// LocaleService
    _localeService = LocaleService.instance();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: _localeService,
      builder: (context, locale, child) {
        return MaterialApp.router(
          locale: locale,
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
      },
    );
  }
}

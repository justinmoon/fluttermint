import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermint/data/prefs.dart';
import 'package:fluttermint/router.dart';
import 'package:fluttermint/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_logging/sentry_logging.dart';

late SharedPreferences prefs;

final prefProvider = createPrefProvider(
  prefs: (_) => prefs,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  getApplicationDocumentsDirectory().then((directory) {
    api.init(path: directory.path);
  });

  await SentryFlutter.init(
    (options) {
      // FIXME: remove this
      options.dsn =
          'https://b012e4556763438e9036b723a15afae6@o1371604.ingest.sentry.io/6675820';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      options.addIntegration(LoggingIntegration());
    },
    appRunner: () => runApp(const ProviderScope(child: App())),
  );
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  static const title = 'Fluttermint';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: white,
          primarySwatch: materialWhite,
          textTheme: textThemeDefault,
          backgroundColor: white,
          scaffoldBackgroundColor: black,
          fontFamily: "Inter"),
    );
  }
}

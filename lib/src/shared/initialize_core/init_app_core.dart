import 'package:firebase_core/firebase_core.dart';
import 'package:repore_agent/firebase_options.dart';
import 'package:repore_agent/lib.dart';

Future<void> initializeCore({required Environment environment}) async {
  AppConfig.environment = environment;

  await PreferenceManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log("$environment");
}

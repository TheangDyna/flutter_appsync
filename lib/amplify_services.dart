import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'amplifyconfiguration.dart';

Future<void> configureAmplify() async {
  final api = AmplifyAPI();
  await Amplify.addPlugin(api);
  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    safePrint('Tried to reconfigure Amplify.');
  }
}

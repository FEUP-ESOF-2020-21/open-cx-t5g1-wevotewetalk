import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'Steps/Login_Step.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"Test/Features/Login.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './Report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..hooks = []
    ..stepDefinitions = [GivenLoginPage(), TypeEmail(), TypePassword(), PressLogin(), LoginFail(), LoginSucess()]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "Test/app.dart"
    // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
    ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}

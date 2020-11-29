import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenLoginPage() {
  return given<FlutterWorld>(
    'I am on the login page',
        (context) async {

    },
  );
}

StepDefinitionGeneric TypeEmail() {
  return when1<String, FlutterWorld>(
    'I type {string} in the email field',
    (email, context) async {
      final emailField = find.byValueKey('email');
      await FlutterDriverUtils.tap(context.world.driver, emailField);
      await FlutterDriverUtils.enterText(context.world.driver, emailField, email);
    },
  );
}

StepDefinitionGeneric TypePassword() {
  return when1<String, FlutterWorld>(
    'I type {string} in the password field',
        (password, context) async {
      final passwordField = find.byValueKey('password');
      await FlutterDriverUtils.tap(context.world.driver, passwordField);
      await FlutterDriverUtils.enterText(context.world.driver, passwordField, password);
    },
  );
}

StepDefinitionGeneric PressLogin() {
  return when<FlutterWorld>(
    'I press the login button',
        (context) async {
      final passwordField = find.byValueKey('loginButton');
      await FlutterDriverUtils.tap(context.world.driver, passwordField);
    },
  );
}

StepDefinitionGeneric LoginSucess() {
  return then<FlutterWorld>(
    'User is logged in',
        (StepContext<FlutterWorld> context) async {
      await FlutterDriverUtils.waitForFlutter(context.world.driver);
      final passwordField = find.byValueKey('logoutButton');
      await FlutterDriverUtils.tap(context.world.driver, passwordField);
    },
  );
}

/*
Feature: Counter
The counter should be incremented when the button is pressed.

Scenario: Counter increases when the button is pressed
Given I expect the "counter" to be "0"
When I tap the "increment" button 10 times
Then I expect the "counter" to be "10"

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric TapButtonNTimesStep() {
  return given2<String, int, FlutterWorld>(
    'I tap the {string} button {int} times',
        (key, count, context) async {
      final locator = find.byValueKey(key);
      for (var i = 0; i < count; i += 1) {
        await FlutterDriverUtils.tap(context.world.driver, locator);
      }
    },
  );
}
*/

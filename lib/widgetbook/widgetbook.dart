import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import '../screens/login_screen.dart';

void main() {
  runApp(
    Widgetbook(
      directories: [
        WidgetbookCategory(
          name: 'Screens',
          children: [
            WidgetbookComponent(
              name: 'Login Screen',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => LoginScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
      // Define the appBuilder to wrap your components inside a MaterialApp
      appBuilder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: child,
          ),
        );
      },
    ),
  );
}

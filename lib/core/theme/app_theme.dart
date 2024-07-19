import 'package:flutter/material.dart';
import 'package:resturant_assigment_app/core/theme/text_theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    textTheme: CustomTextTheme.textTheme
  );
}

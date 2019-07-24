import 'package:flutter/material.dart';

ThemeData buildTheme() {
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      // used for title in login page
      headline: base.headline.copyWith(
        fontFamily: 'Roboto',
        fontSize: 40.0,
        color: const Color(0xFFFE4F1F),
      ),
      title: base.title.copyWith(
        fontFamily: 'Roboto',
        fontSize: 30.0,
        color: const Color(0xFF8ED2E8),
      ),
      caption: base.caption.copyWith(
        color: const Color(0xFFCCC5AF),
      ),
    );
  }

  // We want to override a default light blue theme.
  final ThemeData base = ThemeData.light();

  // And apply changes on it:
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryColor: const Color(0xFF55A9C6),
    indicatorColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    accentColor: const Color(0xFFFFF8E1),
    iconTheme: IconThemeData(
      color: const Color(0xFFCCC5AF),
      size: 20.0,
    ),
    buttonColor: Colors.white,
    backgroundColor: Colors.white,
    tabBarTheme: base.tabBarTheme.copyWith(
      labelColor: const Color(0xFFFFFFFF),
      unselectedLabelColor: const Color(0xFF8ED2E8),
    )
  );
}

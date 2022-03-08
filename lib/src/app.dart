import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const SavedNotes(),
    );
  }
}

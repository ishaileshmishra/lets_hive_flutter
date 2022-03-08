import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_in_flutter/src/constant.dart';
import 'package:hive_in_flutter/src/models/note_model.dart';
import 'package:hive_in_flutter/src/models/timedetail_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  if (kIsWeb) {
    Hive.initFlutter();
  } else {
    // getting the path of the document in the device for accesing the database
    final document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
  }

  // registering adapters
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TimeDetailAdapter());
  await Hive.openBox<Note>(hiveDatabase); // Init and Open the Hive Database

  Box<Note> noteBox = Hive.box<Note>(hiveDatabase);
  debugPrint('${noteBox.values.toList().asMap().entries}');
  runApp(MyApp(settingsController: settingsController));
}

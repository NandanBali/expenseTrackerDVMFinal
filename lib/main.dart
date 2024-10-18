import 'package:expense_tracker_dvm/models/providers/account_provider.dart';
import 'package:expense_tracker_dvm/widgets/main_components/at_a_glance_pane.dart';
import 'package:expense_tracker_dvm/widgets/main_components/history_pane.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker_dvm/globals.dart' as globals;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_dvm/widgets/main_components/floating_button_form.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'payments.db'),
    onCreate: (db, version) {
      return db.execute("CREATE TABLE payments(id INTEGER PRIMARY KEY, amount REAL, category TEXT, description TEXT, time TEXT)");
    },
    version: 1,
  );
  runApp(ChangeNotifierProvider(create: (context) => AccountProvider(database: database), child: const MainApp(),));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Icon themMode = const Icon(Icons.dark_mode);

  //TODO: Fix dark mode
  void _toggleTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
      if (_themeMode == ThemeMode.dark) {
        globals.color1 = Colors.black;
        globals.color2 = Colors.white;
        themMode = const Icon(Icons.light_mode);
        print("color1 = black, color2 = white");
      } else {
        globals.color1 = Colors.white;
        globals.color2 = Colors.black;
        themMode = const Icon(Icons.dark_mode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Title(
              color: Colors.white,
              child: Text(
                "EXPENSE TRACKER",
                style: GoogleFonts.ibmPlexMono(),
              )),
          leading: GestureDetector(
            onTap: () {
              _toggleTheme();
            },
            child: themMode,
          ),
        ),
        backgroundColor: globals.color1,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: const <Widget>[
                AtAGlancePane(),
                SizedBox(height: 24.0),
                HistoryPane(),
              ],
            ),
          ),
        ),
        floatingActionButton: const FloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}

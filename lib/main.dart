import 'package:farmtrace/dairy_page.dart';
import 'package:farmtrace/home.dart';
import 'package:farmtrace/models.dart';
import 'package:farmtrace/layers_page.dart';
import 'package:farmtrace/report_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LayersAdapter());
  await Hive.openBox<Layers>('layers');

  Hive.registerAdapter(FeedingLayersAdapter());
  await Hive.openBox<FeedingLayers>('feedinglayers');

  Hive.registerAdapter(LayersHealthAdapter());
  await Hive.openBox<LayersHealth>('layershealth');

  Hive.registerAdapter(HatchingAdapter());
  await Hive.openBox<Hatching>('hatching');

  Hive.registerAdapter(DairyAdapter());
  await Hive.openBox<Dairy>('dairy'); 

  Hive.registerAdapter(FeedingDairyAdapter());
  await Hive.openBox<FeedingDairy>('feedingdiary');

  Hive.registerAdapter(DairyHealthAdapter());
  await Hive.openBox<DairyHealth>('dairyhealth');

  Hive.registerAdapter(MilkingAdapter());
  await Hive.openBox<Milking>('milking');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Records',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green,
          secondary: Colors.green,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
      ),
      home: const HomePage(),
      routes: {
        '/report': (context) => const ReportPage(),
        '/layers': (context) =>  const LayersPage(),
        '/dairy': (context) => const DairyPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

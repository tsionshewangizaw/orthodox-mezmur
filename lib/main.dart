import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'mezmur_bloc.dart';
import 'widget/app_theme.dart';
import 'splash_screen.dart';
import 'features/theme_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeSettings()),
        BlocProvider(create: (_) => MezmurBloc()),
      ],
      child: const OrthodoxMezmurApp(),
    ),
  );
}

class OrthodoxMezmurApp extends StatelessWidget {
  const OrthodoxMezmurApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSettings = Provider.of<ThemeSettings>(context);

    return MaterialApp(
      title: 'Orthodox Mezmur',
      debugShowCheckedModeBanner: false,
      theme: themeSettings.getThemeData(themeSettings.selectedTheme),
      home: const SplashScreen(),
    );
  }
}

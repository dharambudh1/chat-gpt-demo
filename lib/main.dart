import "package:chat_gpt_demo/util/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:keyboard_dismisser/keyboard_dismisser.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: GetMaterialApp(
        title: "Chat GPT Demo",
        navigatorKey: Get.key,
        theme: getThemeData(brightness: Brightness.light),
        darkTheme: getThemeData(brightness: Brightness.dark),
        initialRoute: AppRoutes.instance.getPages.first.name,
        initialBinding: AppRoutes.instance.getPages.first.binding,
        getPages: AppRoutes.instance.getPages,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  ThemeData getThemeData({required Brightness brightness}) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      applyElevationOverlayColor: true,
    );
  }
}

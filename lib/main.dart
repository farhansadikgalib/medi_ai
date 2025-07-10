import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_value/shared_value.dart';

import 'app/routes/app_pages.dart';
import 'core/binding/initial_binding.dart';
import 'core/constants/app_constants.dart';
import 'core/style/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.bottom],
        );

        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light, // For iOS
          ),
        );

        return SharedValue.wrapApp(
          GetMaterialApp(
            title: "MediAI",
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            initialBinding: InitialBinding(),
            builder: EasyLoading.init(),
            theme: ThemeData(
              useMaterial3: false,
              canvasColor: Colors.white,
              primaryColor: AppColors.primaryColor,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            defaultTransition: transition,
            getPages: AppPages.routes,
            enableLog: kDebugMode,
          ),
        );
      },
    ),
  );
}

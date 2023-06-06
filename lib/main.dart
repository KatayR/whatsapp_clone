import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_clone/Cubit/TapToAddCubit.dart';
import 'Cubit/CurrentTabIndexCubit.dart';
import 'Cubit/TapToAddCubit.dart';
import 'Cubit/DownloadUrlCubit.dart';
import 'firebase_options.dart';
import 'home.dart';

Future main() async {
  // Set the ImagePicker implementation to use the Android photo picker
  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
  }

  // Ensure that the Flutter app is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the default options for the current platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DownloadUrlCubit()),
        BlocProvider(create: (context) => CurrentTabIndexCubit()),
        BlocProvider(create: (context) => TapToCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

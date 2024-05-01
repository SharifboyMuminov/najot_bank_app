import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/app/app.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/service/firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  StorageRepository();

  runApp(App());
}

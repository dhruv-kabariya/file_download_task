import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/theme_service.dart';
import 'data/datasources/rapid_api_client.dart';
import 'data/repositories/file_repository.dart';
import 'domain/entities/file_entity.dart';
import 'presentation/files/bloc/file_bloc.dart';
import 'presentation/files/bloc/file_cubit.dart';
import 'presentation/files/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FileEntityAdapter());
  await Hive.openBox<FileEntity>('files');
  await Hive.openBox('preferences');

  // Initialize FlutterDownloader
  await FlutterDownloader.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FileCubit(
            fileRepo: FileRepository(
              apiClient: RapidApiClient(),
              fileBox: Hive.box<FileEntity>('files'),
              downloader: FlutterDownloader(),
            ),
          )..add(FetchFiles()),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box('preferences').listenable(),
        builder: (context, box, child) {
          return MaterialApp(
            title: 'File Downloader',
            theme: ThemeService.theme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}

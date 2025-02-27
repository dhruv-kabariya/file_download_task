import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/service/storage_permission.dart';
import '../../domain/entities/file_entity.dart';
import '../datasources/rapid_api_client.dart';

class FileRepository {
  final RapidApiClient apiClient;
  final Box<FileEntity> fileBox;
  final FlutterDownloader downloader;

  FileRepository({
    required this.apiClient,
    required this.fileBox,
    required this.downloader,
  });

  Future<List<FileEntity>> getFiles({
    String search = 'cars',
    int page = 1,
  }) async {
    try {
      final apiFiles = await apiClient.getFiles(
        page: page,
        search: search,
      );
      final files = apiFiles
          .map(
            (file) => FileEntity(
              id: file.id,
              downloadUrl: file.download,
              name: file.description,
              url: file.diffrentSizes.isNotEmpty
                  ? file.diffrentSizes.first
                  : file.image,
              type: 'image',
              isDownloaded:
                  fileBox.get(file.id.toString())?.isDownloaded ?? false,
            ),
          )
          .toList();

      // Update local storage
      for (var file in files) {
        await fileBox.put(file.id, file);
      }

      return files;
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }

  Future<void> downloadFile(
    FileEntity file,
  ) async {
    try {
      if (await checkStoragePermission()) {
        final dir = await getApplicationDocumentsDirectory();
        final savedDir = '${dir.path}/downloads';
        await Directory(savedDir).create(recursive: true);

        await FlutterDownloader.enqueue(
          url: file.url,
          savedDir: savedDir,
          // fileName: '${file.name}.${file.type}',
          showNotification: true,
          openFileFromNotification: false,
        );
        file.isDownloaded = true;
        await fileBox.put(file.id, file);
        // FlutterDownloader.registerCallback(callback);
      } else {
        throw Exception('Please Allow Storage Permission');
      }
    } catch (e) {
      throw Exception('Repo Error Download ${e.toString()}');
    }
  }
}

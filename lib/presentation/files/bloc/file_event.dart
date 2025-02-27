part of 'file_bloc.dart';

// Events
abstract class FileEvent {}

class FetchFiles extends FileEvent {
  final String query;
  FetchFiles({this.query = 'cars'});
}

class DownloadFile extends FileEvent {
  final FileEntity file;
  DownloadFile(this.file);
}

class DownloadComplete extends FileEvent {
  final String fileId;
  DownloadComplete(
    this.fileId,
  );
}

class SearchFiles extends FileEvent {
  final String query;
  SearchFiles(this.query);
}

part of 'file_bloc.dart';

// States
class FileState extends Equatable {
  final Map<String, FileEntity> allFiles;
  late final List<FileEntity> files = allFiles.values.toList();
  final Set<String> downloadingFiles;
  final bool isError;
  final String error;
  final bool isLoadingFiles;
  final bool isLoadingMore;

  FileState({
    required this.allFiles,
    required this.downloadingFiles,
    required this.isError,
    required this.error,
    required this.isLoadingFiles,
    required this.isLoadingMore,
  });

  factory FileState.init() {
    return FileState(
      allFiles: {},
      downloadingFiles: {},
      error: "",
      isError: false,
      isLoadingFiles: false,
      isLoadingMore: false,
    );
  }

  FileState copyWith({
    Map<String, FileEntity>? allFiles,
    Set<String>? downloadingFiles,
    bool? isError,
    String? error,
    bool? isLoadingFiles,
    bool? isLoadingMore,
  }) {
    return FileState(
      allFiles: allFiles ?? this.allFiles,
      downloadingFiles: downloadingFiles ?? this.downloadingFiles,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      isLoadingFiles: isLoadingFiles ?? this.isLoadingFiles,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        allFiles,
        files,
        isError,
        error,
        isLoadingFiles,
        isLoadingMore,
        downloadingFiles,
      ];
}

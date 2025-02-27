import 'package:file_downlad_task/domain/entities/file_entity.dart';

import 'file_bloc.dart';
import 'file_cubit.dart';

mixin FileCubitMethods implements FileCubit {
  Future<void> loadFiles(
    FetchFiles event,
    void Function(FileState) emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingFiles: true,
      ),
    );
    try {
      List<FileEntity> newFiles = await fileRepo.getFiles(
        search: event.query,
      );
      emit(
        state.copyWith(
          allFiles: {...state.allFiles, for (FileEntity f in newFiles) f.id: f},
          isLoadingFiles: false,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingFiles: false,
          isLoadingMore: false,
          isError: true,
          error: e.toString(),
        ),
      );
      emit(
        state.copyWith(
          isLoadingFiles: false,
          isLoadingMore: false,
          isError: false,
          error: '',
        ),
      );
    }
  }

  Future<void> downloadFiles(
    DownloadFile event,
    void Function(FileState) emit,
  ) async {
    if (state.downloadingFiles.contains(event.file.id)) {
      return;
    }
    try {
      if (state.downloadingFiles.length < 5) {
        emit(
          state.copyWith(
            downloadingFiles: {
              ...state.downloadingFiles,
              event.file.id,
            },
          ),
        );
        await fileRepo.downloadFile(
          event.file,
        );
        emit(
          state.copyWith(
            downloadingFiles: {...state.downloadingFiles}
              ..remove(event.file.id),
            isError: true,
            error: 'File Downloaded',
          ),
        );
        emit(
          state.copyWith(
            isError: false,
            error: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            isError: true,
            error:
                'Max 5 Concurrent Download Allowed! Please Try Again After Some Time',
          ),
        );
        emit(
          state.copyWith(
            isError: false,
            error: '',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          downloadingFiles: {...state.downloadingFiles}..remove(event.file.id),
          isLoadingFiles: false,
          isLoadingMore: false,
          isError: true,
          error: e.toString(),
        ),
      );
      emit(
        state.copyWith(
          isLoadingFiles: false,
          isLoadingMore: false,
          isError: false,
          error: '',
        ),
      );
    }
  }
}

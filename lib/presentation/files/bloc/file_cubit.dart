import 'package:bloc/bloc.dart';
import 'package:file_downlad_task/data/repositories/file_repository.dart';

import 'file_bloc.dart';

abstract class FileCubit implements Cubit<FileState> {
  factory FileCubit({required FileRepository fileRepo}) => FileBloc(
        repository: fileRepo,
      );

  FileRepository get fileRepo;

  void add(FileEvent event);
}

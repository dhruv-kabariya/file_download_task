import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:file_downlad_task/presentation/files/bloc/file_cubit.dart';
import 'package:file_downlad_task/presentation/files/bloc/file_cubit_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/file_repository.dart';
import '../../../domain/entities/file_entity.dart';

part 'file_event.dart';
part 'file_state.dart';

// BLoC
class FileBloc extends Bloc<FileEvent, FileState>
    with FileCubitMethods
    implements FileCubit {
  @override
  final FileRepository repository;

  FileBloc({required this.repository}) : super(FileState.init()) {
    on<FetchFiles>(
      (event, emit) => loadFiles(event, emit.call),
      transformer: restartable(),
    );
    on<DownloadFile>(
      (event, emit) => downloadFiles(event, emit.call),
      transformer: concurrent(),
    );
  }

  @override
  FileRepository get fileRepo => repository;
}

import 'package:file_downlad_task/domain/entities/file_entity.dart';
import 'package:file_downlad_task/presentation/files/bloc/file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/theme_service.dart';
import '../bloc/file_bloc.dart';
import '../widgets/file_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Downloader'),
        actions: [
          IconButton(
            icon: Icon(
              ThemeService.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () async {
              await ThemeService.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              // controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search files...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                context.read<FileCubit>().add(
                      FetchFiles(
                        query: value,
                      ),
                    );
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<FileCubit, FileState>(
              listener: (context, state) {
                if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.isLoadingFiles) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.files.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.files.length,
                    itemBuilder: (context, index) {
                      final FileEntity f = state.files.elementAt(index);
                      return FileItemWidget(
                        file: f,
                        isDownloading: state.downloadingFiles.contains(f.id),
                        onDownload: (file) {
                          BlocProvider.of<FileCubit>(context).add(
                            DownloadFile(file),
                          );
                          // _handleDownload(file);
                        },
                      );
                    },
                  );
                } else if (state.files.isEmpty) {
                  return Center(
                    child: Text("No Files Found"),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

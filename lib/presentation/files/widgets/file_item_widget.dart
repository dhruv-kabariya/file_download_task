import 'package:flutter/material.dart';

import '../../../domain/entities/file_entity.dart';

class FileItemWidget extends StatelessWidget {
  final FileEntity file;
  final Function(FileEntity) onDownload;
  final bool isDownloading;

  const FileItemWidget({
    super.key,
    required this.file,
    required this.onDownload,
    required this.isDownloading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(file.name),
        subtitle: Text(file.type),
        trailing: isDownloading
            ? CircularProgressIndicator()
            : IconButton(
                icon: Icon(
                  file.isDownloaded ? Icons.check : Icons.download,
                  color: file.isDownloaded ? Colors.green : Colors.blue,
                ),
                onPressed: () => onDownload(file),
              ),
      ),
    );
  }
}

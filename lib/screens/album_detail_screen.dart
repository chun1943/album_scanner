import 'package:flutter/material.dart';
import '../models/album.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('查詢結果')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (album.coverUrl != null)
              Center(
                child: Image.network(album.coverUrl!),
              )
            else
              Center(
                child: Container(
                  width: 160,
                  height: 160,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.album, size: 64, color: Colors.grey.shade700),
                ),
              ),
            const SizedBox(height: 16),
            Text('條碼：${album.barcode}'),
            Text('專輯：${album.title}', style: Theme.of(context).textTheme.titleLarge),
            Text('歌手：${album.artist}'),
            if (album.label != null) Text('發行：${album.label}'),
            if (album.releaseDate != null) Text('發行日：${album.releaseDate!.toIso8601String().substring(0,10)}'),
          ],
        ),
      ),
    );
  }
}



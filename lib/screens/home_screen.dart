import 'package:flutter/material.dart';
import '../models/album.dart';
import 'album_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _barcodeController = TextEditingController();
  String? _errorText;
  bool _loading = false;

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final raw = _barcodeController.text.trim();
    if (raw.isEmpty) {
      setState(() {
        _errorText = '請輸入條碼';
      });
      return;
    }
    setState(() {
      _errorText = null;
    });
    // 導向結果頁（先用假資料）
    setState(() {
      _loading = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _loading = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AlbumDetailScreen(
            album: Album.mockFromBarcode(raw),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('專輯識別')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _barcodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '輸入專輯條碼',
                hintText: '例如：4712345678901',
                errorText: _errorText,
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _onSearch(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _onSearch,
                icon: Icon(Icons.search),
                label: _loading ? Text('查詢中...') : Text('查詢'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
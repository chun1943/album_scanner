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
  List<String> _recentSearches = ['Abbey Road', 'Thriller', 'Dark Side'];

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

  void _onUpload() {
    // 暫時用提示訊息
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('上傳功能開發中...')),
    );
  }

  Widget _buildRecentSearches() {
    if (_recentSearches.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          '最近搜尋',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _recentSearches.length,
            itemBuilder: (context, index) {
              return _buildRecentSearchCard(_recentSearches[index]);
            },
          ),
        ),
      ]
    );

  }

  Widget _buildRecentSearchCard(String albumName) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.album,
              size: 40,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            albumName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🎵 專輯識別')),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('或', style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider()),
              ]
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _onUpload,
                icon: Icon(Icons.upload_file),
                label: Text('上傳專輯照片'),
              ),
            ),
            _buildRecentSearches(),
          ],
        ),
      ),
    );
  }
}
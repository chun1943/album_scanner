class Album {
  final String barcode;
  final String title;
  final String artist;
  final String? coverUrl;
  final String? label;
  final DateTime? releaseDate;

  Album({
    required this.barcode,
    required this.title,
    required this.artist,
    this.coverUrl,
    this.label,
    this.releaseDate,
  });

  factory Album.mockFromBarcode(String barcode) {
    return Album(
      barcode: barcode,
      title: '示例專輯',
      artist: '示例歌手',
      coverUrl: null,
      label: '示例發行',
      releaseDate: DateTime(2020, 1, 1),
    );
  }
}
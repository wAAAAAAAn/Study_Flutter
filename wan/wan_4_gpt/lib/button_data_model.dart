class ButtonData {
  final String title;
  final String imagePath;

  ButtonData({required this.title, required this.imagePath});

  // JSON 데이터를 Dart 객체로 변환
  factory ButtonData.fromJson(Map<String, dynamic> json) {
    return ButtonData(
      title: json['title'],
      imagePath: json['imagePath'],
    );
  }
}

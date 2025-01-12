class WebtoonModel {
  final String title, thumb, id;
  //named construcor로 이렇게 모델.컨스트럭트명 으로 정의 하면 생성자 이름을 마음대로 정의할 수 있다.
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        thumb = json["thumb"],
        id = json["id"];
}

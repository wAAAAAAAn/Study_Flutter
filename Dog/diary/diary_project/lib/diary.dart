class Diary {
  late final String title;
  late final String content;
  late final String password;
  late final String id;
  Diary(
      {required this.title,
      required this.content,
      required this.password,
      required this.id});
  Diary.parseJson(Map values)
      : content = values["contents"],
        title = values["title"],
        password = values["password"],
        id = values["id"];
}

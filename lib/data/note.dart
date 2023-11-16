class Note {
  late String id;
  late String title;
  late String body;

  Note({
    required this.id,
    required this.title,
    required this.body,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}

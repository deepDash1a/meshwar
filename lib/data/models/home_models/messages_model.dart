class MessagesModel {
  final String title;
  final String content;
  bool isRead;
  bool isFav;

  MessagesModel({
    required this.title,
    required this.content,
    required this.isRead,
    required this.isFav,
  });
}

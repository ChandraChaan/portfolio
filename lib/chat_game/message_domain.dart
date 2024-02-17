class Messages {
  final String msg;
  final bool left;
  final String shape;
  final String sender;
  final String? timestamp;
  final List<String> images;
  final String song;

  Messages(
      {required this.msg,
        required this.left,
        required this.shape,
        required this.song,
        required this.sender,
         this.timestamp,
        required this.images}
      );
}
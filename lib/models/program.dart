class Program {
  final String id;
  final String title;
  final String duration;
  final String tag;
  final String imageUrl;

  Program({
    required this.id,
    required this.title,
    required this.duration,
    required this.tag,
    required this.imageUrl,
  });

  factory Program.fromFirestore(Map<String, dynamic> data, String docId) {
    return Program(
      id: docId,
      title: data['title'] ?? '',
      duration: data['duration'] ?? '',
      tag: data['tag'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
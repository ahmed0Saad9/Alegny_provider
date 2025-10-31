class Chapters {
  final int id;
  final String title;
  final String description;
  final String subjectName;

  Chapters({
    required this.id,
    required this.title,
    required this.description,
    required this.subjectName,
  });

  // From JSON
  factory Chapters.fromJson(Map<String, dynamic> json) {
    return Chapters(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subjectName: json['subjectName'],
    );
  }
}

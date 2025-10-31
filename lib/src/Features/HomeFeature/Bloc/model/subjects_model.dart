class Subjects {
  final int id;
  final String title;
  final String description;
  final int academicYear;
  final String semester;

  Subjects({
    required this.id,
    required this.title,
    required this.description,
    required this.academicYear,
    required this.semester,
  });

  factory Subjects.fromJson(Map<String, dynamic> json) {
    return Subjects(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      academicYear: json['academicYear'],
      semester: json['semester'],
    );
  }
}

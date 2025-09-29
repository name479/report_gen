class Report {
  final int? id;
  final String title;
  final String name;
  final String intro;
  final String objectives;
  final String method;
  final String results;
  final String conclusion;
  final DateTime dateCreated;
  final String? pdfPath; // تم إضافة هذا الحقل

  Report({
    this.id,
    required this.title,
    required this.name,
    required this.intro,
    required this.objectives,
    required this.method,
    required this.results,
    required this.conclusion,
    required this.dateCreated,
    this.pdfPath, // تم إضافة هذا هنا
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'intro': intro,
      'objectives': objectives,
      'method': method,
      'results': results,
      'conclusion': conclusion,
      'dateCreated': dateCreated.toIso8601String(),
      'pdfPath': pdfPath, // تم تضمينه في دالة الحفظ
    };
  }

  static Report fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'],
      title: map['title'],
      name: map['name'],
      intro: map['intro'],
      objectives: map['objectives'],
      method: map['method'],
      results: map['results'],
      conclusion: map['conclusion'],
      dateCreated: DateTime.parse(map['dateCreated']),
      pdfPath: map['pdfPath'], // تم تضمينه في دالة القراءة
    );
  }
}
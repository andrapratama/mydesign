class Schedule {
  final int? id;
  final String title;
  final String note;
  final DateTime date;

  Schedule({
    this.id,
    required this.title,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'note': note,
    'date': date.toIso8601String(),
  };

  factory Schedule.fromMap(Map<String, dynamic> map) => Schedule(
    id: map['id'],
    title: map['title'],
    note: map['note'],
    date: DateTime.parse(map['date']),
  );
}

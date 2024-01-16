class Habit{
  final DateTime startTime;
  final DateTime endTime;

  final String name;
  final InterestCategory interestCategory;

  Habit({required this.name, required this.startTime, required this.endTime, required this.interestCategory});
}

enum InterestCategory {
  sports,
  learning,
  reading,
  movies,
}
class Score {
  final String id;
  final String uid;
  final DateTime time;
  final String category;
  final int categoryIndex;
  final String difficultyLevel;
  final String score;
  final int attempts;
  final int wrongAttempts;
  final int correctAttempts;

  Score(
    this.difficultyLevel,
    this.attempts,
    this.wrongAttempts,
    this.correctAttempts,
    this.uid,
    this.time,
    this.score,
    this.category,
    this.categoryIndex,
    this.id,
  );

  Map<String, dynamic> toJson() => {
        'userId': uid,
        'time': time,
        'score': score,
        'category': category,
        'categoryIndex': categoryIndex,
        'id': id,
        'difficultyLevel': difficultyLevel,
        'attempts': attempts,
        'wrongAttempts': wrongAttempts,
        'correctAttempts': correctAttempts
      };
}

class ResponseOnSolution {
  final String id;
  final bool isCorrect;


  ResponseOnSolution({
    required this.id,
    required this.isCorrect,
  });

  factory ResponseOnSolution.fromJson(Map<String, dynamic> json) {
    return ResponseOnSolution(
      id: json['id'],
      isCorrect: json['correct'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'correct': isCorrect,
  };
}

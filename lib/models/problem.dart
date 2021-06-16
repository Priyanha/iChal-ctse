class Problem {
  final String id;
  final String age;
  final String mStatus;
  final String occupation;
  final String problem;

  Problem(
      {this.age,
       this.mStatus,
       this.occupation,
       this.problem,
       this.id});

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
        age: json['age'],
        mStatus: json['mStatus'],
        occupation: json['occupation'],
        problem: json['problem'],
        id: json["_id"]);
  }
}

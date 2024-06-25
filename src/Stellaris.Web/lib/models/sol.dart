class CurrentSols {
  final List<String> value;

  CurrentSols({
    required this.value,
  });

  factory CurrentSols.fromJson(Map<String, dynamic> json) {
    return CurrentSols(
      value: List<String>.from(json['sol_keys'].map((sol) => 'SOL $sol')),
    );
  }
}

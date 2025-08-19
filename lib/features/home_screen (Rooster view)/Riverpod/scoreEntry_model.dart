// // ignore_for_file: file_names

// class ScoreEntry {
//   final String id;        // unique for the entry
//   final String matchId;   // or match index
//   final DateTime at;
//   final double goals;
//   final double gl;
//   final double agl;
//   final double minusGl;
//   final double minusAgl;

//   const ScoreEntry({
//     required this.id,
//     required this.matchId,
//     required this.at,
//     this.goals = 0,
//     this.gl = 0,
//     this.agl = 0,
//     this.minusGl = 0,
//     this.minusAgl = 0,
//   });

//   ScoreEntry copyWith({
//     String? id,
//     String? matchId,
//     DateTime? at,
//     double? goals,
//     double? gl,
//     double? agl,
//     double? minusGl,
//     double? minusAgl,
//   }) {
//     return ScoreEntry(
//       id: id ?? this.id,
//       matchId: matchId ?? this.matchId,
//       at: at ?? this.at,
//       goals: goals ?? this.goals,
//       gl: gl ?? this.gl,
//       agl: agl ?? this.agl,
//       minusGl: minusGl ?? this.minusGl,
//       minusAgl: minusAgl ?? this.minusAgl,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'matchId': matchId,
//     'at': at.toIso8601String(),
//     'goals': goals,
//     'gl': gl,
//     'agl': agl,
//     'minusGl': minusGl,
//     'minusAgl': minusAgl,
//   };

//   factory ScoreEntry.fromJson(Map<String, dynamic> json) => ScoreEntry(
//     id: json['id'] as String,
//     matchId: json['matchId'] as String,
//     at: DateTime.parse(json['at'] as String),
//     goals: (json['goals'] ?? 0).toDouble(),
//     gl: (json['gl'] ?? 0).toDouble(),
//     agl: (json['agl'] ?? 0).toDouble(),
//     minusGl: (json['minusGl'] ?? 0).toDouble(),
//     minusAgl: (json['minusAgl'] ?? 0).toDouble(),
//   );
// }

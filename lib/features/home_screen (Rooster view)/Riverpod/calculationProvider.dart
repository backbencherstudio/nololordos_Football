// // computed_providers.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';
// import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/scoreBookProvider.dart';
// import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/scoreEntry_model.dart';


// class PlayerAggregates {
//   final double totalGoals;
//   final double totalGl;
//   final double totalAgl;
//   final double totalMinusGl;
//   final double totalMinusAgl;

//   final double sr;        // example: goals per match
//   final double glAvg;
//   final double aglAvg;
//   final double minusGlAvg;
//   final double minusAglAvg;

//   const PlayerAggregates({
//     required this.totalGoals,
//     required this.totalGl,
//     required this.totalAgl,
//     required this.totalMinusGl,
//     required this.totalMinusAgl,
//     required this.sr,
//     required this.glAvg,
//     required this.aglAvg,
//     required this.minusGlAvg,
//     required this.minusAglAvg,
//   });
// }

// final playerAggregatesProvider =
//     Provider.family<PlayerAggregates, String>((ref, playerId) {
//   final book = ref.watch(scoreBookProvider);
//   final matches = ref.watch(matchCountProvider);
//   final entries = book[playerId] ?? const <ScoreEntry>[];

//   double sumGoals = 0, sumGl = 0, sumAgl = 0, sumMGl = 0, sumMAgl = 0;
//   for (final e in entries) {
//     sumGoals += e.goals;
//     sumGl += e.gl;
//     sumAgl += e.agl;
//     sumMGl += e.minusGl;
//     sumMAgl += e.minusAgl;
//   }

//   final d = matches == 0 ? 1 : matches; // guard div-by-zero; or use 0 if you prefer

//   return PlayerAggregates(
//     totalGoals: sumGoals,
//     totalGl: sumGl,
//     totalAgl: sumAgl,
//     totalMinusGl: sumMGl,
//     totalMinusAgl: sumMAgl,
//     sr: sumGoals / d,
//     glAvg: sumGl / d,
//     aglAvg: sumAgl / d,
//     minusGlAvg: sumMGl / d,
//     minusAglAvg: sumMAgl / d,
//   );
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/matchDay_screen.dart';

final playerTotalStatsProvider = StateProvider<Map<String, PlayerStats>>(
  (ref) => {},
);

final strProvider = StateProvider<List<double>>((ref) => []);

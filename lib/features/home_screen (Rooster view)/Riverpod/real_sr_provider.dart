import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a provider to store SR per player
final realSrProvider = StateProvider<Map<String, double>>((ref) => {});

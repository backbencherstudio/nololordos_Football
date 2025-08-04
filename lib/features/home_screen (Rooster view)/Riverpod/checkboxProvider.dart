import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectAllGKProvider = StateProvider<bool>((ref) => false);
final selectAllFwdProvider = StateProvider<bool>((ref) => false);
final selectAllDefProvider = StateProvider<bool>((ref) => false);
final selectAllMIDProvider = StateProvider<bool>((ref) => false);


final selectedPlayersProvider = StateProvider<List<int>>((ref) => []);
final selectedGKPlayersProvider = StateProvider<List<int>>((ref) => []);
final selectedFwdPlayersProvider = StateProvider<List<int>>((ref) => []);
final selectedDefPlayersProvider = StateProvider<List<int>>((ref) => []);
final selectedMIDPlayersProvider = StateProvider<List<int>>((ref) => []);

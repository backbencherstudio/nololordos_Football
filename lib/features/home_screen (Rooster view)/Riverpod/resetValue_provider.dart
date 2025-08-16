// Reset all values provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/Riverpod/playerProvider.dart';

final resetAllValuesProvider = Provider<void>((ref) {
  // Reset player-related state
  ref.read(playersProvider.notifier).resetAllValues(); 

  
  ref.read(matchCountProvider.notifier).state = 0.00; 
  ref.read(scoreCountPerMatch.notifier).state = 0; 
});



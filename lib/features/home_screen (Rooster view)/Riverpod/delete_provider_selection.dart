
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to track selected players for deletion (keep if already used)
final deletePlayerIdListProvider = StateProvider<List<String>>((ref) => []);



///
void addPlayerId(WidgetRef ref, String id) {
  final currentList = ref.read(deletePlayerIdListProvider);
  if (!currentList.contains(id)) {
    ref.read(deletePlayerIdListProvider.notifier).state = [
      ...currentList,
      id,
    ];
  }
}

void removePlayerId(WidgetRef ref, String id) {
  final currentList = ref.read(deletePlayerIdListProvider);
  ref.read(deletePlayerIdListProvider.notifier).state =
      currentList.where((element) => element != id).toList();
}

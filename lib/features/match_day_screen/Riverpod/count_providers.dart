import 'package:flutter_riverpod/flutter_riverpod.dart';

final goalIncreamentProvider = StateProvider<int>((ref)=>0);

final goalOccuredProvider = StateProvider<int>((ref)=>0);

final scoresprovider = StateProvider<int?>((ref)=>null);
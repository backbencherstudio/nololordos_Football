import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';

void showNumberMenu(
  BuildContext context,
  GlobalKey key,
  WidgetRef ref,
  StateProvider<String> provider,
) {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero); // top-left position

  showMenu<String>(
    context: context,
    color: AppColors.primaryContainer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    position: RelativeRect.fromRect(
      offset & const Size(40, 40),
      Offset.zero & overlay.size,
    ),
    items: [
      PopupMenuItem<String>(
        value: "Goalkeeper (GK)",
        child: Text("Goalkeeper (GK)", style: TextStyle(fontSize: 16)),
      ),
      PopupMenuItem<String>(
        value: "Defender (DEF)",
        child: Text("Defender (DEF)", style: TextStyle(fontSize: 16)),
      ),
      PopupMenuItem<String>(
        value: "Midfielder (MID)",
        child: Text("Midfielder (MID)", style: TextStyle(fontSize: 16)),
      ),
      PopupMenuItem<String>(
        value: "Forward (FWD)",
        child: Text("Forward (FWD)", style: TextStyle(fontSize: 16)),
      ),
    ],
  ).then((String? value) {
    if (value != null) {
      ref.read(provider.notifier).state = value;
    }
  });
}

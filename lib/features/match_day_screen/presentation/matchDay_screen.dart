import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/constant/padding.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/import_export_screen/presentation/widgets/custom_buttons.dart';
import 'package:nololordos/features/match_day_screen/Riverpod/player_notifier.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/alert_dialogue_box.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_inputfields.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/custom_score_inputBox.dart';

class MatchdayScreen extends ConsumerWidget {
  const MatchdayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(playerListProvider);
    final notifier = ref.read(playerListProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55.h),
              CustomInputfields(),
              SizedBox(height: 24.h),

              Column(
                children: List.generate(players.length, (index) {
                  final p = players[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomScoreInputbox(
                      name: p.name,
                      goals: p.goals,
                      ownGoals: p.ownGoals,
                      selectedScore: p.selectedScore,
                      onNameChanged: (value) =>
                          notifier.updateName(index, value),
                      onIncrementGoals: () => notifier.incrementGoals(index),
                      onIncrementOwnGoals: () =>
                          notifier.incrementOwnGoals(index),
                      onScoreSelected: (score) =>
                          notifier.selectScore(index, score),
                    ),
                  );
                }),
              ),

              CustomButtons(
                 hieght: 60.h,
                title: '+ Add the list',
                icon: '',
                onTap: () => notifier.addPlayer(),
      
              ),
              SizedBox(height: 20.h,),

              CustomButtons(
                 hieght: 60.h,
                 color: AppColors.buttonAvtiveColor,
                title: 'Submit',
                icon: '',
              onTap: (){
                alertDialogueBox(context);
              },
      
              ),
              SizedBox(height: 140.h,)
            ],
          ),
        ),
      ),
    );
  }
}

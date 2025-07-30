import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nololordos/core/theme/theme_extension/app_colors.dart';
import 'package:nololordos/features/home_screen%20(Rooster%20view)/presentation/widgets/customBox_tile.dart';
import 'package:nololordos/features/match_day_screen/presentation/widgets/inputdecoration.dart';

class GkContainer extends StatelessWidget {
  const GkContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding:EdgeInsets.symmetric(vertical:12.h ) ,
      decoration: BoxDecoration(color: AppColors.primaryContainer),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(
        padding: const EdgeInsets.only(left:24),
        child: Column(
        
          children: [
          SizedBox(height: 11.5.h,),
          Text("GK"),
          SizedBox(height: 7.h,),
          SizedBox(
            width: 144.w,
            child: Divider(color: AppColors.containerTextColor,thickness: 1.5, indent: 0,  // Optional: Adjust indent
                    endIndent: 0, ),
          ),
         SizedBox(height: 2.h,),
           SizedBox(
            height: 40.h,
            width: 144.w,
             child: TextFormField(
              decoration: customInputDecoration(),
             ),
           )
        
        ],),
      ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
              
              horizontalMargin: 8.w, 
              columnSpacing: 8.w, 
            dataRowMinHeight: 50.h,
            dataRowMaxHeight: 50.h,
                columns: [
                  DataColumn(label: Text("SR")),
                  DataColumn(label: Text("GM")),
                  DataColumn(label: Text("GL")),
                  DataColumn(label: Text("AGL")),
                  DataColumn(label: Text("-GL")),
                  DataColumn(label: Text("-AGL")),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(CustomboxTile()),
                    DataCell(CustomboxTile()),
                    DataCell(CustomboxTile()),
                    DataCell(CustomboxTile()),
                    DataCell(CustomboxTile()),
                    DataCell(CustomboxTile()),
                  ]),
                  
                ]),
            ),
          ),
        ],
      )
    );
  }
}

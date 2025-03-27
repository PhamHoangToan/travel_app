import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';

class DashlineWidget extends StatelessWidget{
  const DashlineWidget({Key? key, this.height=1,  this.color=ColorPalette.dividerColor}):super(key: key);
  final double height;
  final Color color;


  @override 
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constrants){
        final boxWidth=constrants.constrainWidth();
        const dashWith=6.0;
        final dashHeight=height;
        final dashCount=(boxWidth/(2*dashWith)).floor();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(
            dashCount,
            (_){
              return SizedBox(
                width: dashWith,
                height: dashHeight,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              );
            }
            ), 
          ),
        );

      }
      );
  }
}
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularSlider extends StatelessWidget {
  CircularSlider(
      {super.key,
      required this.progressBarColors,
      required this.trackColor,
      required this.shadowColor,
      required this.bottomLabelText,
      required this.data,
      required this.unity});

  List<MaterialColor> progressBarColors = [];
  MaterialAccentColor trackColor;
  MaterialAccentColor shadowColor;
  String bottomLabelText;
  double data;
  String unity;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SleekCircularSlider(
        appearance: CircularSliderAppearance(
            customWidths: CustomSliderWidths(
                trackWidth: 5,
                progressBarWidth: 10,
                shadowWidth: 5,
                handlerSize: 5),
            customColors: CustomSliderColors(
                dynamicGradient: true,
                gradientStartAngle: 0,
                gradientEndAngle: 360,
                trackGradientStartAngle: 0,
                trackGradientEndAngle: 360,
                trackColor: trackColor,
                progressBarColors: progressBarColors,
                shadowColor: shadowColor,
                shadowMaxOpacity: 0.3,
                //);
                shadowStep: 7),
            infoProperties: InfoProperties(
                bottomLabelStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                bottomLabelText: bottomLabelText,
                mainLabelStyle: TextStyle(
                    color: Colors.orange,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600),
                modifier: (double value) {
                  return '${data} ${unity}';
                }),
            startAngle: 90,
            animDurationMultiplier: 5,
            angleRange: 360,
            size: 175.0,
            animationEnabled: true),
        min: 0,
        max: 100,
        initialValue: data >= 0 ? data : 0);
  }
}

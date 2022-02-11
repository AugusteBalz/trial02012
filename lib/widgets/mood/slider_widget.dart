import 'package:flutter/material.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import '../../models/custom_slider_thumb_circle.dart';

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final OneMood md;

  SliderWidget(
      {this.sliderHeight = 48,
      this.max = 10,
      this.min = 0,
      this.fullWidth = false,
      required this.md});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (widget.fullWidth) paddingFactor = .3;

    return Container(
      width: widget.fullWidth ? double.infinity : (widget.sliderHeight) * 3.8,
      height: (widget.sliderHeight),

      child: Padding(
        padding: EdgeInsets.fromLTRB(widget.sliderHeight * paddingFactor, 2,
            widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: widget.md.color.withOpacity(1),
                    inactiveTrackColor: widget.md.color.withOpacity(.5),


                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: widget.sliderHeight * .4,
                      min: widget.min,
                      max: widget.max,
                    ),
                    overlayColor: widget.md.color.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: widget.md.color.withOpacity(1),
                    inactiveTickMarkColor: widget.md.color.withOpacity(.5),
                  ),
                  child: Slider(
                    divisions: 10,
                      value: _value,
                      onChanged: (value) {
                        setState(() {


                            widget.md.strength = (value*10).toInt();

                          _value = value;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              width: widget.sliderHeight * .1,
            ),
          ],
        ),
      ),
    );
  }
}

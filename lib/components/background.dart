
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitter/colors.dart';
import 'package:splitter/size_config.dart';

class Background extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().creamBG,
      body: Column(
        children: [
          Transform.rotate(angle: 40,
            child: Container(
              child: CustomPaint(
                painter: OpenPainter(color: AppColors().yellow, offset: 0),
              ),
            ),
          ),
          Transform.rotate(angle: 40,
            child: Container(
              child: CustomPaint(
                painter: OpenPainter(color: AppColors().maroon, offset: 100),
              ),
            ),
          ),
          Transform.rotate(angle: 40,
            child: Container(
              child: CustomPaint(
                painter: OpenPainter(color: AppColors().purple, offset: 200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  final Color color;
  double offset;
  OpenPainter({required this.color,required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(-450,-450 - offset) & Size(SizeConfig.screenWidth*3, SizeConfig.screenHeight*0.125), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class BackgroundStack extends StatelessWidget {
  const BackgroundStack({Key? key, required this.builder}) : super(key: key);
  final Widget builder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        builder,
      ],
    );
  }
}


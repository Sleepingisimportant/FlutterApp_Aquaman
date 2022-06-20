import 'package:aquaman/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';

class WaterWave2 extends StatefulWidget {
  @override
  _WaterWave2State createState() => _WaterWave2State();
}

class _WaterWave2State extends State<WaterWave2>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  double waveHeightIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: false);

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.slowMiddle,
    ));
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose(); // you need this
  }

  @override
  Widget build(BuildContext context) {
    double waveHeightIndex =
        Provider.of<GeneralData>(context).waveHeightIndexData;

    //

    return SlideTransition(
      position: _offsetAnimation,
      child: Stack(children: [
        Container(
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: WaterWaveBlue(waveHeightIndex: waveHeightIndex),
          ),
        ),
        Container(
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: WaterWaveLightBlue(
              waveHeightIndex: waveHeightIndex,
            ),
          ),
        )
      ]),
    );
  }
}

class WaterWaveLightBlue extends CustomPainter {
  final double waveHeightIndex;
  WaterWaveLightBlue({@required this.waveHeightIndex});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(kWaveDeepBlueColor);
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * waveHeightIndex);
    path.quadraticBezierTo(
        size.width * 0.25,
        size.height * (waveHeightIndex + 0.045),
        size.width * 0.5,
        size.height * waveHeightIndex);
    path.quadraticBezierTo(
        size.width * 0.75,
        size.height * (waveHeightIndex - 0.045),
        size.width * 1.0,
        size.height * waveHeightIndex);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WaterWaveBlue extends CustomPainter {
  final double waveHeightIndex;
  WaterWaveBlue({@required this.waveHeightIndex});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(kWaveLightBlueColor);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * (waveHeightIndex + 0.06));

    path.quadraticBezierTo(
      size.width * 0.45,
      size.height * (waveHeightIndex - 0.07),
      size.width * 0.90,
      size.height * waveHeightIndex,
    );
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * (waveHeightIndex + 0.07),
      size.width * 1.0,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

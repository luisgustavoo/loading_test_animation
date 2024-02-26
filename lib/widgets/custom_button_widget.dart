import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget({this.isLoading = false, super.key});

  final bool isLoading;

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget>
    with TickerProviderStateMixin
// SingleTickerProviderStateMixin
{
  late AnimationController _animationController;
  late AnimationController _animationRotateController;
  late Animation<double> _animation;
  late Animation<double> _animationRotate;
  final endAnimation = 360.0;
  final marginTop = 16.0;
  final marginBottom = 16.0;
  final buttonHeight = 60.0;
  double turns = 0.0;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _startAnimation2();
    // });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(
            begin: 0.0, end: (buttonHeight - (marginTop + marginBottom)))
        .animate(_animationController);

    _animationRotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    final Animation<double> curve = CurvedAnimation(
      parent: _animationRotateController,
      curve: Curves.easeOutExpo,
    );

    _animationRotate = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
  }

  void _startAnimation() {
    _animationController.forward().whenComplete(() {
      // _animationRotateController.repeat();
      _startAnimation2();
    });
  }

  void _startAnimation2() {
    setState(() {
      turns += 1;
    });
  }

  void _stopAnimation() {
    _animationController.stop();
    _animationRotateController.stop();

    _animationController.reset();
    _animationRotateController.reset();
  }

  @override
  void didUpdateWidget(covariant CustomButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(' oldWidget $oldWidget ');
    if (widget.isLoading) {
      _startAnimation();
    } else {
      _stopAnimation();
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (widget.isLoading) {
  //     _startAnimation();
  //   } else {
  //     _stopAnimation();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: Size(200, buttonHeight)),
      onPressed: () {},
      child: widget.isLoading
          ? AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return AnimatedRotation(
                  turns: turns,
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    width: _animation.value,
                    height: 3,
                  ),
                  onEnd: () {
                    Future<void>.delayed(
                      const Duration(
                        milliseconds: 200,
                      ),
                    ).whenComplete(() => _startAnimation2());
                  },
                );

                // return AnimatedBuilder(
                //   animation: _animationRotateController,
                //   builder: (context, child) {
                //     return Transform.rotate(
                //       angle: _animationRotate.value * math.pi / 180,
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Theme.of(context).primaryColor,
                //         ),
                //         width: _animation.value,
                //         height: 3,
                //       ),
                //     );
                //   },
                // );
              },
            )
          : const Text('Continue'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfoli_web/utils/font_style.dart';

class TypewriterTextAnimation extends StatefulWidget {
  final String text;
  final Duration duration;
  final BoxConstraints? constraints;

  const TypewriterTextAnimation({super.key, 
    required this.text,
    required this.duration,
    this.constraints,
  });

  @override
  _TypewriterTextAnimationState createState() =>
      _TypewriterTextAnimationState();
}

class _TypewriterTextAnimationState extends State<TypewriterTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _textAnimation = IntTween(begin: 0, end: widget.text.length)
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        final animatedText = widget.text.substring(0, _textAnimation.value);
        return Container(
          constraints: widget.constraints,
          child: SelectableText(animatedText,
              style: FontStyles.body.copyWith(
                color: Theme.of(context).primaryColor,
              )),
        );
      },
    );
  }
}

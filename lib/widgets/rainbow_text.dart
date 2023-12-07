import 'package:flutter/cupertino.dart';

// A StatelessWidget that creates text with a color gradient effect
class RainbowText extends StatelessWidget {

  final String text;
  final TextStyle? style;
  final Gradient gradient; // The color gradient to apply to the text

  const RainbowText({super.key, required this.text, required this.style, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn, // Blend mode to apply the shader to the text
      shaderCallback: (bounds) =>
          gradient.createShader( // Create a shader from the gradient
            Rect.fromLTWH(0, 0, bounds.width, bounds.height), // Defining the area for the shader
          ),
      child: Text(text, style: style), // The text Widget to be displayed
    );
  }

}
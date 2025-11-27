import 'package:flutter/material.dart';

class CustomTitleLarge extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const CustomTitleLarge({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}

class CustomTitleMedium extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const CustomTitleMedium({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class CustomBodyLarge extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const CustomBodyLarge({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: color ?? Colors.grey.shade600),
    );
  }
}

class CustomBodyMedium extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const CustomBodyMedium({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
    );
  }
}

class CustomBodySmall extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const CustomBodySmall({
    super.key,
    required this.text,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
    );
  }
}

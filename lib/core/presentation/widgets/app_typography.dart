import 'package:flutter/material.dart';

class AppTitleLarge extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const AppTitleLarge({
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

class AppTitleMedium extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const AppTitleMedium({
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

class AppBodyLarge extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const AppBodyLarge({
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

class AppBodyMedium extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const AppBodyMedium({
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

class AppBodySmall extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const AppBodySmall({
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

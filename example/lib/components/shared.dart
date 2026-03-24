import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';

/// Shared scaffold for all demo pages
class DemoScaffold extends StatelessWidget {
  const DemoScaffold({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DCText(
          title,
          fontSize: DCFontSize.xl,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: DCColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DCSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

/// Section title used within demo pages
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DCSpacing.md, top: DCSpacing.sm),
      child: DCText(
        title,
        fontSize: DCFontSize.md,
        fontWeight: FontWeight.w700,
        color: DCColors.primary,
      ),
    );
  }
}

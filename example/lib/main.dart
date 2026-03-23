import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'datc_design Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: DCColors.primary),
      ),
      home: const DemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DCText('datc_design Demo', fontSize: DCFontSize.xl),
        backgroundColor: DCColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DCSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Typography Demo
            const DCText('Typography', fontSize: DCFontSize.xxl),
            const SizedBox(height: DCSpacing.md),
            const DCText('DCFontSize.xl', fontSize: DCFontSize.xl),
            const SizedBox(height: DCSpacing.sm),
            DCText('DCFontSize.normal', fontSize: DCFontSize.normal),
            const SizedBox(height: DCSpacing.sm),
            DCText('DCFontSize.sm', fontSize: DCFontSize.sm),

            const SizedBox(height: DCSpacing.xl),

            /// Button Demo
            const DCText('Buttons', fontSize: DCFontSize.xxl),
            const SizedBox(height: DCSpacing.md),
            DCButton(
              onPressed: () {},
              label: 'Primary Button',
              icon: Icons.arrow_forward,
            ),
            const SizedBox(height: DCSpacing.md),
            DCInkWell(onTap: () {}, label: 'DC InkWell', icon: Icons.touch_app),

            const SizedBox(height: DCSpacing.xl),

            /// Colors Demo
            const DCText('Colors', fontSize: DCFontSize.xxl),
            const SizedBox(height: DCSpacing.md),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: DCColors.primary,
                borderRadius: BorderRadius.circular(DCSpacing.md),
              ),
              child: const Center(
                child: DCText('Primary', color: Colors.white),
              ),
            ),
            const SizedBox(height: DCSpacing.sm),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: DCColors.secondary,
                borderRadius: BorderRadius.circular(DCSpacing.md),
              ),
              child: const Center(
                child: DCText('Secondary', color: Colors.white),
              ),
            ),
            const SizedBox(height: DCSpacing.sm),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: DCColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DCSpacing.md),
              ),
              child: const Center(child: DCText('Primary opacity 0.1')),
            ),
          ],
        ),
      ),
    );
  }
}

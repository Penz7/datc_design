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

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  int? _radioValue = 1;
  bool _checkboxValue1 = true;
  bool _checkboxValue2 = false;

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
            const DCText('DCFontSize.normal', fontSize: DCFontSize.normal),
            const SizedBox(height: DCSpacing.sm),
            const DCText('DCFontSize.sm', fontSize: DCFontSize.sm),

            const SizedBox(height: DCSpacing.xl),

            /// Selection Controls Demo
            const DCText('Selection Controls', fontSize: DCFontSize.xxl),
            const SizedBox(height: DCSpacing.md),

            const DCText('Radio Items (Grouped)', fontSize: DCFontSize.normal),
            const SizedBox(height: DCSpacing.sm),
            DCListRadio<int>(
              groupValue: _radioValue,
              onChanged: (val) => setState(() => _radioValue = val),
              items: [
                DCRadioOption(
                  value: 1,
                  title: 'Option 1',
                  subtitle: 'Subtitle 1',
                ),
                DCRadioOption(
                  value: 2,
                  title: 'Option 2',
                  subtitle: 'Subtitle 2',
                ),
              ],
            ),

            const SizedBox(height: DCSpacing.md),
            const DCText('Checkbox Items', fontSize: DCFontSize.normal),
            const SizedBox(height: DCSpacing.sm),
            DCCheckboxItem(
              value: _checkboxValue1,
              title: 'Checkbox 1',
              subtitle: 'I am selected',
              onChanged: (val) => setState(() => _checkboxValue1 = val!),
            ),
            DCCheckboxItem(
              value: _checkboxValue2,
              title: 'Checkbox 2',
              subtitle: 'I am not selected',
              onChanged: (val) => setState(() => _checkboxValue2 = val!),
              controlAffinity: ListTileControlAffinity.trailing,
            ),

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
          ],
        ),
      ),
    );
  }
}

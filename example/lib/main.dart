import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';

import 'components/dc_text_demo.dart';
import 'components/dc_button_demo.dart';
import 'components/dc_inkwell_demo.dart';
import 'components/dc_list_demo.dart';
import 'components/dc_radio_demo.dart';
import 'components/dc_checkbox_demo.dart';
import 'components/dc_rich_text_demo.dart';
import 'components/dc_text_field_demo.dart';
import 'components/dc_image_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DATC Design Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: DCColors.primary),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      _MenuItem(
        title: 'DCText',
        subtitle: 'Typography & text styles',
        icon: Icons.text_fields,
        page: const DCTextDemo(),
      ),
      _MenuItem(
        title: 'DCButton',
        subtitle: 'Buttons with variants & sizes',
        icon: Icons.smart_button,
        page: const DCButtonDemo(),
      ),
      _MenuItem(
        title: 'DCInkWell',
        subtitle: 'Touchable surfaces',
        icon: Icons.touch_app,
        page: const DCInkWellDemo(),
      ),
      _MenuItem(
        title: 'DCList & DCListItem',
        subtitle: 'Lists with items',
        icon: Icons.list,
        page: const DCListDemo(),
      ),
      _MenuItem(
        title: 'DCRadio & DCListRadio',
        subtitle: 'Single selection controls',
        icon: Icons.radio_button_checked,
        page: const DCRadioDemo(),
      ),
      _MenuItem(
        title: 'DCCheckbox & DCListCheckbox',
        subtitle: 'Multiple selection controls',
        icon: Icons.check_box,
        page: const DCCheckboxDemo(),
      ),
      _MenuItem(
        title: 'DCRichText',
        subtitle: 'Rich text with multiple spans',
        icon: Icons.text_format,
        page: const DCRichTextDemo(),
      ),
      _MenuItem(
        title: 'DCTextField',
        subtitle: 'Input fields and debounced search',
        icon: Icons.input_rounded,
        page: const DCTextFieldDemo(),
      ),
      _MenuItem(
        title: 'DCImage',
        subtitle: 'Cached network images with Shimmer',
        icon: Icons.image_outlined,
        page: const DCImageDemo(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: DCText(
          'DATC Design System',
          fontSize: DCFontSize.xl,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: DCColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: DCSpacing.md),
        itemCount: menuItems.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: DCColors.primary.withValues(alpha: 0.1),
              child: Icon(item.icon, color: DCColors.primary),
            ),
            title: DCText(
              item.title,
              fontSize: DCFontSize.normal,
              fontWeight: FontWeight.w600,
            ),
            subtitle: DCText(
              item.subtitle,
              fontSize: DCFontSize.tiny,
              color: DCColors.textSecondary,
            ),
            trailing: const Icon(Icons.chevron_right, color: DCColors.gray400),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item.page),
            ),
          );
        },
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget page;

  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.page,
  });
}

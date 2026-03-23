import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCTextFieldDemo extends StatefulWidget {
  const DCTextFieldDemo({super.key});

  @override
  State<DCTextFieldDemo> createState() => _DCTextFieldDemoState();
}

class _DCTextFieldDemoState extends State<DCTextFieldDemo> {
  String _searchResult = '';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCTextField & Search',
      children: [
        const SectionTitle('Search Field with Debounce'),
        DCTextFieldSearch(
          hintText: 'Search for something...',
          onSearch: (value) {
            setState(() {
              _searchResult = value;
            });
            if (value.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Searching for: $value')));
            }
          },
        ),
        if (_searchResult.isNotEmpty) ...[
          const SizedBox(height: DCSpacing.sm),
          DCText(
            'Latest search query: "$_searchResult"',
            color: DCColors.textSecondary,
            fontSize: DCFontSize.sm,
          ),
        ],
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Basic Text Fields'),
        const DCTextField(
          labelText: 'Full Name',
          hintText: 'Enter your full name',
        ),
        const SizedBox(height: DCSpacing.md),
        const DCTextField(
          labelText: 'Email Address',
          hintText: 'name@example.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icon(Icons.email_outlined, color: DCColors.gray500),
        ),
        const SizedBox(height: DCSpacing.md),
        const DCTextField(
          labelText: 'Password',
          hintText: 'Enter password',
          obscureText: true,
          prefixIcon: Icon(Icons.lock_outline, color: DCColors.gray500),
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('States'),
        const DCTextField(
          labelText: 'Error State',
          hintText: 'Validation failed',
          errorText: 'This field is required',
        ),
        const SizedBox(height: DCSpacing.md),
        const DCTextField(
          labelText: 'Disabled State',
          hintText: 'You cannot edit this',
          enabled: false,
        ),
      ],
    );
  }
}

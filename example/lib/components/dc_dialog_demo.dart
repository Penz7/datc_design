import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCDialogDemo extends StatelessWidget {
  const DCDialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCDialog & DCDialogProvider',
      children: [
        const SectionTitle('Message Dialog'),
        DCButton.fill(
          onPressed: () {
            DCDialogProvider.instance.showMessageDialog(
              context,
              title: 'Welcome',
              message: 'This is a standard message dialog from DC Design System.',
              buttonTitle: 'Got it',
            );
          },
          label: 'Show Message Dialog',
        ),
        const SizedBox(height: DCSpacing.md),
        DCButton.fill(
          onPressed: () {
            DCDialogProvider.instance.showMessageDialog(
              context,
              message: 'This message dialog has no title.',
            );
          },
          label: 'Show No Title Dialog',
          backgroundColor: DCColors.secondary,
        ),
        
        const SectionTitle('Confirm Dialog'),
        DCButton.fill(
          onPressed: () async {
            final result = await DCDialogProvider.instance.showConfirmDialog(
              context,
              title: 'Confirm Delete',
              message: 'Are you sure you want to delete this item? This action cannot be undone.',
              confirmTitle: 'Delete',
              confirmColor: DCColors.error,
            );
            
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result ? 'Item Deleted' : 'Action Cancelled'),
                  backgroundColor: result ? DCColors.error : DCColors.gray600,
                ),
              );
            }
          },
          label: 'Show Confirm Dialog',
          backgroundColor: DCColors.error,
        ),
        
        const SectionTitle('Custom Dialog'),
        DCButton.fill(
          onPressed: () {
            DCDialogProvider.instance.showCustomDialog(
              context,
              backgroundColor: DCColors.gray900,
              borderRadius: 24,
              padding: const EdgeInsets.all(DCSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.rocket_launch, color: Colors.orange, size: 48),
                  const SizedBox(height: DCSpacing.md),
                  DCText.bold(
                    'Custom Content',
                    color: Colors.white,
                    fontSize: DCFontSize.lg,
                  ),
                  const SizedBox(height: DCSpacing.sm),
                  DCText.regular(
                    'This dialog uses a completely custom widget tree and custom styling (dark background, large radius).',
                    color: Colors.white70,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                  const SizedBox(height: DCSpacing.lg),
                  DCButton.fill(
                    onPressed: () => Navigator.pop(context),
                    label: 'Close Custom',
                    backgroundColor: Colors.orange,
                  ),
                ],
              ),
            );
          },
          label: 'Show Custom Body Dialog',
          backgroundColor: DCColors.gray800,
        ),
      ],
    );
  }
}

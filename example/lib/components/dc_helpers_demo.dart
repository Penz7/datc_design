import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';

class DCHelpersDemo extends StatefulWidget {
  const DCHelpersDemo({super.key});

  @override
  State<DCHelpersDemo> createState() => _DCHelpersDemoState();
}

class _DCHelpersDemoState extends State<DCHelpersDemo> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpers Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DCSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'DateTimeHelper',
              children: [
                _buildInfoRow('Now:', DateTimeHelper.getDateTimeNow(DateTimeFormat.HHmm_ddMMyyyy_splash)),
                _buildInfoRow('Formatted:', DateTimeHelper.getString(_selectedDate, format: DateTimeFormat.dd_MM_YYYY)),
                _buildInfoRow('Time Ago:', DateTimeHelper.convertTimeAgo(
                  DateTime.now().subtract(const Duration(hours: 2)).toUtc().toIso8601String(),
                  DateTimeFormat.yyyy_MM_ddTHH_mm_ss,
                  DateTimeFormat.dd_MM_YYYY
                )),
              ],
            ),
            const SizedBox(height: DCSpacing.lg),
            _buildSection(
              title: 'DateTimePickerHelper',
              children: [
                DCButton.fill(
                  label: 'Show Date Picker',
                  onPressed: () {
                    DateTimePickerHelper.instance.showDatePicker(
                      (date) => setState(() => _selectedDate = date),
                      context: context,
                      now: _selectedDate,
                    );
                  },
                ),
                const SizedBox(height: DCSpacing.sm),
                DCButton.fill(
                  label: 'Show Time Picker',
                  backgroundColor: DCColors.secondary,
                  onPressed: () {
                    DateTimePickerHelper.instance.showTimePicker(
                      (date) => setState(() => _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        date.hour,
                        date.minute,
                      )),
                      context: context,
                    );
                  },
                ),
                const SizedBox(height: DCSpacing.sm),
                DCButton.outline(
                  label: 'Show DateTime Picker',
                  onPressed: () {
                    DateTimePickerHelper.instance.showDateTimePicker(
                      (date) => setState(() => _selectedDate = date),
                      context: context,
                      now: _selectedDate,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DCText(
          title,
          fontSize: DCFontSize.lg,
          fontWeight: FontWeight.bold,
          color: DCColors.primary,
        ),
        const SizedBox(height: DCSpacing.sm),
        Card(
          elevation: 0,
          color: DCColors.gray50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DCSpacing.sm),
            side: const BorderSide(color: DCColors.gray200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DCSpacing.md),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DCSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DCText(label, fontWeight: FontWeight.w500),
          DCText(value, color: DCColors.textSecondary),
        ],
      ),
    );
  }
}

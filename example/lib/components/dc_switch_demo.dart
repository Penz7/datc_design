import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCSwitchDemo extends StatefulWidget {
  const DCSwitchDemo({super.key});

  @override
  State<DCSwitchDemo> createState() => _DCSwitchDemoState();
}

class _DCSwitchDemoState extends State<DCSwitchDemo> {
  bool _basic = false;
  bool _notifications = true;
  bool _darkMode = false;
  bool _wifi = true;
  bool _bluetooth = false;
  bool _custom = true;
  bool _disabled = false;
  bool _small = false;
  bool _medium = true;
  bool _large = false;
  bool _onOff = true;
  bool _leading = false;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCSwitch',
      children: [
        // ── Basic ───────────────────────────────────────────────────────────
        const SectionTitle('Basic'),
        DCSwitch(value: _basic, onChanged: (v) => setState(() => _basic = v)),

        // ── With Labels ──────────────────────────────────────────────────────
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Labeled (trailing)'),
        DCSwitch.labeled(
          value: _notifications,
          onChanged: (v) => setState(() => _notifications = v),
          label: 'Push Notifications',
        ),
        const SizedBox(height: DCSpacing.md),
        DCSwitch.labeled(
          value: _darkMode,
          onChanged: (v) => setState(() => _darkMode = v),
          label: 'Dark Mode',
          labelStyle: const TextStyle(
            fontSize: DCFontSize.normal,
            fontWeight: FontWeight.w600,
            color: DCColors.textPrimary,
          ),
        ),

        // ── Label Position Leading ────────────────────────────────────────────
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Labeled (leading)'),
        DCSwitch.labeled(
          value: _leading,
          onChanged: (v) => setState(() => _leading = v),
          label: 'Auto-save',
          labelPosition: DCSwitchLabelPosition.leading,
        ),

        // ── Sizes ─────────────────────────────────────────────────────────────
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Sizes'),
        DCSwitch.labeled(
          value: _small,
          onChanged: (v) => setState(() => _small = v),
          label: 'Small',
          size: DCSwitchSize.small,
        ),
        const SizedBox(height: DCSpacing.md),
        DCSwitch.labeled(
          value: _medium,
          onChanged: (v) => setState(() => _medium = v),
          label: 'Medium (default)',
          size: DCSwitchSize.medium,
        ),
        const SizedBox(height: DCSpacing.md),
        DCSwitch.labeled(
          value: _large,
          onChanged: (v) => setState(() => _large = v),
          label: 'Large',
          size: DCSwitchSize.large,
        ),

        // ── Custom Colors ─────────────────────────────────────────────────────
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Custom Colors'),
        DCSwitch.labeled(
          value: _wifi,
          onChanged: (v) => setState(() => _wifi = v),
          label: 'Wi-Fi',
          activeTrackColor: DCColors.secondary,
          activeThumbColor: Colors.white,
          inactiveTrackColor: DCColors.gray200,
        ),
        const SizedBox(height: DCSpacing.md),
        DCSwitch.labeled(
          value: _bluetooth,
          onChanged: (v) => setState(() => _bluetooth = v),
          label: 'Bluetooth',
          activeTrackColor: const Color(0xFF3B82F6),
          inactiveTrackColor: DCColors.gray300,
          activeTrackBorderColor: const Color(0xFF1D4ED8),
        ),

        // ── Inner Track Labels ────────────────────────────────────────────────
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Inner Track Labels (ON / OFF)'),
        DCSwitch(
          value: _onOff,
          onChanged: (v) => setState(() => _onOff = v),
          size: DCSwitchSize.large,
          onLabel: 'ON',
          offLabel: 'OFF',
          activeTrackColor: DCColors.primary,
        ),

        // ── Custom Style ──────────────────────────────────────────────────────
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Fully Custom'),
        DCSwitch.labeled(
          value: _custom,
          onChanged: (v) => setState(() => _custom = v),
          label: 'Premium Mode 🔥',
          labelStyle: const TextStyle(
            fontSize: DCFontSize.md,
            fontWeight: FontWeight.w700,
            color: DCColors.primary,
          ),
          size: DCSwitchSize.large,
          activeTrackColor: DCColors.primary,
          activeThumbColor: Colors.amber,
          inactiveTrackColor: DCColors.gray200,
          inactiveThumbColor: DCColors.gray400,
          padding: const EdgeInsets.symmetric(
            horizontal: DCSpacing.md,
            vertical: DCSpacing.sm,
          ),
        ),

        // ── Disabled ─────────────────────────────────────────────────────────
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Disabled'),
        DCSwitch.labeled(
          value: _disabled,
          onChanged: (v) => setState(() => _disabled = v),
          label: 'Disabled (off)',
          isDisabled: true,
        ),
        const SizedBox(height: DCSpacing.md),
        DCSwitch.labeled(
          value: true,
          onChanged: (v) {},
          label: 'Disabled (on)',
          isDisabled: true,
          activeTrackColor: DCColors.primary,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCListDemo extends StatelessWidget {
  const DCListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCList & DCListItem',
      children: [
        const SectionTitle('DCListItem'),
        DCListItem(
          title: 'Basic Item',
          subtitle: 'With subtitle',
          onTap: () {},
        ),
        const Divider(),
        DCListItem(
          title: 'With Leading',
          subtitle: 'Circle avatar leading',
          leading: const CircleAvatar(
            backgroundColor: DCColors.primary,
            child: Icon(Icons.person, color: Colors.white),
          ),
          onTap: () {},
        ),
        const Divider(),
        DCListItem(
          title: 'With Trailing',
          subtitle: 'Arrow icon trailing',
          leading: const CircleAvatar(
            backgroundColor: DCColors.secondary,
            child: Icon(Icons.star, color: Colors.white),
          ),
          trailing: const Icon(Icons.chevron_right, color: DCColors.gray400),
          onTap: () {},
        ),
      ],
    );
  }
}

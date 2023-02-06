import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:brilloconnetz_test/src/general_widgets/two_colored_text.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const TwoColoredText(first: 'Brillo', second: 'Connectz'),
                const Divider(height: 32, color: Colors.black54),
                const Spacing.smallHeight(),
                Text(
                  "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                  style: textTheme.headline5,
                ),
                const Spacing.mediumHeight(),
                Text(
                  'Developer Contact',
                  style: textTheme.headline5?.copyWith(
                    fontSize: 20,
                  ),
                ),
                const Divider(color: Colors.black54),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.email, color: Colors.black54),
                  title: Text('Email : gusanum5@gmail.com'),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      Icon(Icons.location_on_outlined, color: Colors.black54),
                  title: Text('Address : Lagos Nigeria.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

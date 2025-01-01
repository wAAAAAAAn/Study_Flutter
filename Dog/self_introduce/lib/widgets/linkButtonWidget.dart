import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Linkbuttonwidget extends StatefulWidget {
  late final String link;
  late final Icon icon_;
  late final String name;
  // ignore: prefer_const_constructors_in_immutables
  Linkbuttonwidget(
      {super.key, required this.link, required this.icon_, required this.name});

  @override
  State<Linkbuttonwidget> createState() =>
      // ignore: no_logic_in_create_state
      _LinkbuttonwidgetState(link: link, icon_: icon_, name: name);
}

class _LinkbuttonwidgetState extends State<Linkbuttonwidget> {
  late final String link;
  late final Icon icon_;
  late final String name;
  _LinkbuttonwidgetState(
      {required this.link, required this.icon_, required this.name});
  void openLink() async {
    var url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          IconButton(
            onPressed: openLink,
            icon: icon_,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Transform.translate(offset: const Offset(-15, 0), child: Text(name))
        ],
      ),
    );
  }
}

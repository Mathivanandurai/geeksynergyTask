import 'package:flutter/material.dart';
import 'package:task/components/constants/text_style.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: <Widget>[
          Row(
            children: [
              const Icon(Icons.info),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                  child: Text(
                "Company Details",
                style: GetTextStyleTask.styleS20w700Black,
              )),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          titleSubtitleText("Company", "Geeksynergy Technologies Pvt Ltd"),
          const SizedBox(
            height: 10,
          ),
          titleSubtitleText("Address", "Sanjayanagar, Bengaluru-56"),
          const SizedBox(
            height: 10,
          ),
          titleSubtitleText("Phone", "XXXXXXXXX09"),
          const SizedBox(
            height: 10,
          ),
          titleSubtitleText("Email", "XXXXXX@gmail.com"),
        ],
      ),
    );
  }

  Widget titleSubtitleText(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: GetTextStyleTask.styleS20w700Black.copyWith(fontSize: 16),
        ),
        Flexible(
            child: Text(subtitle,
                style: GetTextStyleTask.styleS20w700Grey.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16))),
      ],
    );
  }
}

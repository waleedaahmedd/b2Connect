import 'package:flutter/material.dart';

import 'language_selection_button.dart';

class AppBarWithBackIconAndLanguage extends StatelessWidget
    implements PreferredSizeWidget {
  final IconData? icon;
  final Function() onTapIcon;

  AppBarWithBackIconAndLanguage({Key? key, this.icon, required this.onTapIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconData? iconImage = icon ?? Icons.arrow_back;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        padding: EdgeInsets.zero,


        icon: Icon(
          iconImage,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          onTapIcon();
          //Navigator.pop(context);
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
          child: LanguageSelectionButton(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
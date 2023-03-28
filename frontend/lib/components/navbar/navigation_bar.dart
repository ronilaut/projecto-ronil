import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

class TopMenuBar extends StatefulWidget {
  const TopMenuBar({super.key});

  @override
  State<TopMenuBar> createState() => _TopMenuBarState();
}

class _TopMenuBarState extends State<TopMenuBar> {
  late final List<PlutoMenuItem> whiteHoverMenus;

  late final List<PlutoMenuItem> orangeHoverMenus;

  late final List<PlutoMenuItem> whiteTapMenus;

  late final List<PlutoMenuItem> orangeTapMenus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    whiteHoverMenus = _makeMenus(context);
    //orangeHoverMenus = _makeMenus(context);
    //whiteTapMenus = _makeMenus(context);
    //orangeTapMenus = _makeMenus(context);
  }

  void message(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<PlutoMenuItem> _makeMenus(BuildContext context) {
    return [
      PlutoMenuItem(
        title: 'Home',
        onTap: () => message(context, 'Menu 3 tap'),
      ),
      PlutoMenuItem(
        title: 'Recursos Humanos',
        children: [
          PlutoMenuItem(
            title: 'Formulários',
            onTap: () => message(context, 'Menu 6-1 tap'),
          ),
          PlutoMenuItem(
            title: 'Organograma',
            onTap: () => message(context, 'Menu 6-2 tap'),
          ),
        ],
      ),
      PlutoMenuItem(
        title: 'ICT',
        children: [
          PlutoMenuItem(
            title: 'Manuais',
            onTap: () => message(context, 'Menu 6-1 tap'),
          ),
          PlutoMenuItem(
            title: 'Formação',
            onTap: () => message(context, 'Menu 6-2 tap'),
          ),
          PlutoMenuItem(
            title: 'Organograma',
            onTap: () => message(context, 'Menu 6-2 tap'),
          ),
          PlutoMenuItem(
            title: 'Formulários',
            onTap: () => message(context, 'Menu 6-2 tap'),
          ),
        ],
      ),
      PlutoMenuItem(
        title: 'Jira',
        onTap: () => message(context, 'Menu 5 tap'),
      ),
      PlutoMenuItem(
        title: 'Webmail',
        onTap: () => message(context, 'Menu 5 tap'),
      ),
      PlutoMenuItem(
        title: 'App Me',
        onTap: () => message(context, 'Menu 5 tap'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlutoMenuBar(
              itemStyle: const PlutoMenuItemStyle(
                  textStyle: TextStyle(color: Colors.white)),
              height: 55,
              backgroundColor: Colors.blueAccent,
              mode: PlutoMenuBarMode.hover,
              menus: whiteHoverMenus,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


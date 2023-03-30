
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intranet/constants.dart';

import 'side_bar_container.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SidebarContainer(
      title: "Pesquisar",
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: "Escreva aqui ...",
          suffixIcon: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: SvgPicture.asset("assets/icons/feather_search.svg"),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kDefaultPadding / 2),
              ),
              borderSide: BorderSide(color: Color(0xFFCCCCCC))),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intranet/constants.dart';
import 'package:get/get.dart';
import 'package:intranet/controllers/menuController.dart';

class WebMenu extends StatelessWidget {
  WebMenu({
    super.key,
  });
  final MenuControllers _controller = Get.put(MenuControllers());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          _controller.menuItems.length,
          (index) => WebMenuItem(
            text: _controller.menuItems[index],
            isActive: index == _controller.selectedIndex,
            press: () => _controller.setMenuIndex(index),
          ),
        ),
      ),
    );
  }
}

class WebMenuItem extends StatefulWidget {
  const WebMenuItem({
    super.key,
    required this.isActive,
    required this.text,
    required this.press,
  });

  final bool isActive;
  final String text;
  final VoidCallback press;

  @override
  State<WebMenuItem> createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;
  Color _borderColor() {
    if (widget.isActive) {
      return kRedColor;
    } else if (!widget.isActive & _isHover) {
      return kRedColor.withOpacity(0.4);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _borderColor(),
              width: 3,
            ),
          ),
        ),
        duration: kDefaultDuration,
        child: Text(
          widget.text,
          style: TextStyle(
              color: Colors.white,
              fontWeight:
                  widget.isActive ? FontWeight.w500 : FontWeight.normal),
        ),
      ),
    );
  }
}

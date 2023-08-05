import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onPressed,
    this.title,
    this.widget,
    this.isTitle = true,
    this.isSearch = true,
  });

  final String? title;
  final void Function()? onPressed;
  final Widget? widget;
  final bool isTitle;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      width: size.width,
      child: Row(
        children: [
          widget ?? const SizedBox.shrink(),
          isTitle
              ? Text(
                  title!,
                  style: TextStyle(fontSize: size.height * 0.03),
                )
              : FadeInUp(
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    'assets/title.png',
                    height: size.height * 0.1,
                    fit: BoxFit.fill,
                  ),
                ),
          const Spacer(),
          isSearch
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'searchCharacters');
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

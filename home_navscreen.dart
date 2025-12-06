import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:showup_mobile_app/curved_navigator_navbar.dart';

class FancyBottomNav extends StatefulWidget {
  @override
  State<FancyBottomNav> createState() => _FancyBottomNavState();
}

class _FancyBottomNavState extends State<FancyBottomNav> {
  int currentIndex = 0;

  // Convert SVG paths to UI Path
  Path iconFromSvg(String svg) => parseSvgPathData(svg);

  final icons = [
    "M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z", // home
    "M18 2H6a2 2 0 0 0-2 2v16l8-4 8 4V4a2 2 0 0 0-2-2z", // book
    "M19.14 12.94c.04-.3.06-.61.06-.94s-.02-.64-.06-.94l2.03-1.58a.5.5 0 0 0 .11-.64l-1.92-3.32a.5.5 0 0 0-.61-.22l-2.39.96a7.007 7.007 0 0 0-1.62-.94l-.36-2.54A.5.5 0 0 0 14.29 2h-4.58a.5.5 0 0 0-.5.42l-.36 2.54c-.6.24-1.16.55-1.67.94l-2.39-.96a.5.5 0 0 0-.61.22L2.66 8.78a.5.5 0 0 0 .11.64l2.03 1.58c-.04.3-.06.61-.06.94s.02.64.06.94L2.77 14.5a.5.5 0 0 0-.11.64l1.92 3.32c.14.24.43.34.68.22l2.39-.96c.51.39 1.07.7 1.67.94l.36 2.54c.05.25.26.42.5.42h4.58c.25 0 .45-.17.5-.42l.36-2.54c.6-.24 1.16-.55 1.67-.94l2.39.96c.25.12.54.02.68-.22l1.92-3.32a.5.5 0 0 0-.11-.64l-2.03-1.56zM12 15.5A3.5 3.5 0 1 1 12 8.5a3.5 3.5 0 0 1 0 7z", // settings
    "M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z", // person profile
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          icons.length,
          (index) {
            final isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () => setState(() => currentIndex = index),
              child: AnimatedScale(
                scale: isSelected ? 1.35 : 1.0,
                duration: Duration(milliseconds: 300),
                child: AnimatedDrawIcon(
                  iconPath: iconFromSvg(icons[index]),
                  isSelected: isSelected,
                  color: isSelected ? Colors.pink : Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

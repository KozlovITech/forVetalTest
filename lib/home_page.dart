import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solid_software_test_app/screens/bonus_screen.dart';
import 'package:solid_software_test_app/screens/main_screen.dart';
import 'package:solid_software_test_app/themes/color_theme.dart';
import 'package:solid_software_test_app/themes/text_theme.dart';

  ///Home Page
class HomePage extends StatelessWidget {
  ///Constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.dark_purple,
        title: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text(
              "SOLID SOFTWARE TEST APP",
              style: Fonts.appBar,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorTheme.dark_purple,
        child: Column(
          children: [
            const Divider(
              height: 10,
              thickness: 3,
              indent: 15,
              endIndent: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Text(
                "If you want to see the colors change, then click the "
                "'Standard Task' Button. However, if you want to see "
                "additional features, click on the Cat)",
                style: Fonts.main_text,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(20, 24, 35, 1),
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return ColorTheme.dark_orange;
                    }
                    return null;
                  },
                ),
                side: MaterialStateProperty.all(const BorderSide(
                  color: ColorTheme.dark_orange,
                  width: 2.0,
                ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Standard Task",
                  style: Fonts.button,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BonusScreen(),
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/img/cat_1.svg',
                  semanticsLabel: 'My SVG Image',
                  height: 200,
                  width: 200,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

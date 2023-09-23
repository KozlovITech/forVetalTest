import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solid_software_test_app/screens/bonus_screen.dart';
import 'package:solid_software_test_app/screens/main_screen.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(20, 24, 35, 1),
        title: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text(
              "SOLID SOFTWARE TEST APP",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(240, 83, 21, 1),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromRGBO(20, 24, 35, 1),
        child:  Column(
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
                "If you want to see the colors change, then click the 'Standard Task' Button. However, if you want to see additional features, click on the Cat)",
                style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(196,197,198,1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainScreen()),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(20, 24, 35, 1)),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return const Color.fromRGBO(240, 83, 21, 1);
                      return null;
                    },
                  ),
                  side: MaterialStateProperty.all(const BorderSide(
                    color: Color.fromRGBO(240, 83, 21, 1),
                    width: 2.0,
                  )),
                ),

                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Standart Task",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
                      builder: (context) => const BonusScreen()),
                ),
                child:  SvgPicture.asset(
                   'assets/img/cat_1.svg',
                  semanticsLabel: 'My SVG Image',
                  height: 200,
                  width: 200,
                  color: Colors.white,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

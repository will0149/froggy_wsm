import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Back"),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //     ),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        height: size.height / 1.4,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.9,
              image: NetworkImage(
                  "https://w0.peakpx.com/wallpaper/107/456/HD-wallpaper-cyan-alegre-animado-cian-colorido-divertido-emoticono-simple-sonrisa.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Stack(
            children: [
              Positioned(
                  top: 40,
                  left: size.width * 0.05,
                  child: Text(
                      S.of(context).parkeaAndShare,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  )
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.10,
                    right: size.width * 0.10,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                          S.of(context).joinOurUniverse,
                          style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        ),

                      ),
                      const Divider(),
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          child: Text(
                            S.of(context).login,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          style: buttonStyle,
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          child: Text(
                            S.of(context).signUp,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: () {},
                          style: buttonStyle,
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


ButtonStyle buttonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22.0),
      side: const BorderSide(
          color: Colors.white,
          width: 1.2
      ),
    ),
  ),
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.all(10),
  ),
  foregroundColor:
  MaterialStateProperty.all<Color>(Colors.lightBlueAccent.withOpacity(0.2)),
  backgroundColor:
  MaterialStateProperty.all<Color>(Colors.lightBlueAccent.withOpacity(0.2)),
);

import 'package:apresentacao/features/authentication/sign_in_view.dart';
import 'package:apresentacao/features/form-validation/sign_up_view.dart';
import 'package:flutter/material.dart';

class Welcome_view extends StatelessWidget {
  const Welcome_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor:const  Color(0xFFFFFFFF),
        body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("imagens/easport.png",width: size.width*0.4,),
                const Text(
                     "Texto",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    )),
                const Text(
                  "texto",
                    style: TextStyle(
                        color:Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0)),

                SizedBox(height: size.height * 0.01),

                const Text(
                  "texto",
                  style: TextStyle(color: Color(0xFF9E9E9E)),
                ),

                SizedBox(height: size.height * 0.1),

                Container(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInView()),
                      );
                    },
                    child: const Text("Iniciar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shadowColor: Colors.transparent,
                        textStyle:const TextStyle(
                            color: Colors.white54,
                            fontSize: 23,
                            fontFamily: "Brand Bold"
                            , fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ),

                Container(
                  width: size.width * 0.8,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()),
                      );
                    },
                    child: const Text(
                     "Inscrever-se",
                      style: TextStyle(color:Color(0xFF000000)),
                    ),
                    style: TextButton.styleFrom(
                     backgroundColor: Colors.grey
                  ),
                  ),
                )
              ],
            ),
          ),

    );
  }
}

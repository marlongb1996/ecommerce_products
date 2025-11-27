import 'package:ecommerce_products/pages/products/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
          clientId: '875380705356-97ca6tfin81bbsljblhgf611rj48cgfb.apps.googleusercontent.com'
      );
      // Cierra sesión anterior
      await googleSignIn.signOut();
      final GoogleSignInAccount? gUser = await GoogleSignIn.instance.authenticate();
      if (gUser == null) {
        debugPrint('Google sign-in canceled by user');
        return;
      }
      final GoogleSignInAuthentication? gAuth = await gUser.authentication;
      if (gAuth == null) {
        debugPrint('Google authentication returned null');
        return;
      }
      final gCredentials = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(gCredentials);

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        debugPrint('Firebase user is null');
        return;
      }else{
        debugPrint('Fireabse user: ${firebaseUser?.email}');
        if(context.mounted){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ProductPage()),
          );
        }

      }
    } catch (e) {
      print("Google Sign-In error: $e");
    }
  }

  Future<void> signInWithFacebook() async {
    // final LoginResult result = await FacebookAuth.instance.login();
    //
    // if (result.status == LoginStatus.success) {
    //   final credential = FacebookAuthProvider.credential(result.accessToken!.token);
    //   await FirebaseAuth.instance.signInWithCredential(credential);
    // }
  }


  void fakeLogin() {
    print("Login normal presionado");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Responsive.responsivePadding(
          context: context,
          mobile: const EdgeInsets.all(25),
          tablet: const EdgeInsets.all(40),
          desktop: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
          largeDesktop: const EdgeInsets.symmetric(horizontal: 200, vertical: 60),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: Responsive.responsiveTextSize(
                      context: context,
                      mobile: 30,
                      tablet: 36,
                      desktop: 42,
                      largeDesktop: 50,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: Responsive.responsiveValue(
                    context: context, mobile: 30, tablet: 40, desktop: 50, largeDesktop: 60)),

                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Nombre de usuario",
                    border: OutlineInputBorder(
                      borderRadius: Responsive.responsiveBorderRadius(
                        context: context,
                        mobile: BorderRadius.circular(8),
                        tablet: BorderRadius.circular(12),
                        desktop: BorderRadius.circular(16),
                        largeDesktop: BorderRadius.circular(20),
                      ),
                    ),
                    contentPadding: Responsive.responsivePadding(
                      context: context,
                      mobile: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      tablet: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      desktop: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      largeDesktop: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    ),
                  ),
                ),

                SizedBox(height: Responsive.responsiveValue(
                    context: context, mobile: 20, tablet: 25, desktop: 30, largeDesktop: 40)),

                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Contraseña",
                    border: OutlineInputBorder(
                      borderRadius: Responsive.responsiveBorderRadius(
                        context: context,
                        mobile: BorderRadius.circular(8),
                        tablet: BorderRadius.circular(12),
                        desktop: BorderRadius.circular(16),
                        largeDesktop: BorderRadius.circular(20),
                      ),
                    ),
                    contentPadding: Responsive.responsivePadding(
                      context: context,
                      mobile: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      tablet: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      desktop: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      largeDesktop: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(
                        fontSize: Responsive.responsiveTextSize(
                          context: context,
                          mobile: 12,
                          tablet: 14,
                          desktop: 16,
                          largeDesktop: 18,
                        ),
                      ),
                    ),
                    onPressed: () {
                      print("Recuperar contraseña");
                    },
                  ),
                ),

                SizedBox(height: Responsive.responsiveValue(
                    context: context, mobile: 20, tablet: 25, desktop: 30, largeDesktop: 40)),

                ElevatedButton.icon(
                  onPressed: fakeLogin,
                  icon: Icon(Icons.login),
                  label: Text(
                    "Iniciar sesión",
                    style: TextStyle(
                      fontSize: Responsive.responsiveTextSize(
                        context: context,
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                        largeDesktop: 22,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      Responsive.responsiveValue(context: context, mobile: double.infinity, tablet: 300, desktop: 400, largeDesktop: 500),
                      50,
                    ),
                  ),
                ),

                SizedBox(height: Responsive.responsiveValue(
                    context: context, mobile: 20, tablet: 25, desktop: 30, largeDesktop: 40)),

                ElevatedButton.icon(
                  onPressed: () => signInWithGoogle(context),
                  icon: Image.asset(
                    'assets/google_logo.png',
                    height: Responsive.responsiveValue(context: context, mobile: 20, tablet: 25, desktop: 30, largeDesktop: 35),
                  ),
                  label: Text(
                    "Continuar con Google",
                    style: TextStyle(
                      fontSize: Responsive.responsiveTextSize(
                        context: context,
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                        largeDesktop: 22,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(
                      Responsive.responsiveValue(context: context, mobile: double.infinity, tablet: 300, desktop: 400, largeDesktop: 500),
                      50,
                    ),
                  ),
                ),

                SizedBox(height: Responsive.responsiveValue(
                    context: context, mobile: 10, tablet: 15, desktop: 20, largeDesktop: 25)),

                // Botón Facebook
                ElevatedButton.icon(
                  onPressed: signInWithFacebook,
                  icon: Image.asset(
                    'assets/facebook_logo.png',
                    height: Responsive.responsiveValue(context: context, mobile: 20, tablet: 25, desktop: 30, largeDesktop: 35),
                  ),
                  label: Text(
                    "Continuar con Facebook",
                    style: TextStyle(
                      fontSize: Responsive.responsiveTextSize(
                        context: context,
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                        largeDesktop: 22,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1877F2),
                    foregroundColor: Colors.white,
                    minimumSize: Size(
                      Responsive.responsiveValue(context: context, mobile: double.infinity, tablet: 300, desktop: 400, largeDesktop: 500),
                      50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }
}

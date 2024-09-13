import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 190),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Login to your Account',
                  style: GoogleFonts.exo2(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 27,
            ),
            TextField(
              controller: controller.txtEmail,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            TextField(
              controller: controller.txtPassword,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            GestureDetector(
              onTap: () async {
                String response = await AuthService.authService.signInWithEmailAndPassword(
                  controller.txtEmail.text,
                  controller.txtPassword.text,
                );

                User? user = AuthService.authService.getCurrentUser();

                if(user!=null && response=="success")
                  {
                    Get.offAndToNamed('/home');
                  }
                else
                  {
                    Get.snackbar('Sign In Failed', response);
                  }
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  color: Color(
                    0xff1f319d,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 58,
            ),
            Text(
              '- Or sign in with -',
              style: GoogleFonts.exo(
                wordSpacing: -0.5,
                color: Colors.grey[500],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await GoogleAuthService.googleAuthService.signInWithGoogle();
                    User? user = AuthService.authService.getCurrentUser();
                    if(user!=null)
                    {
                      Get.offAndToNamed('/home');
                    }
                  },
                  child: Image.asset(
                    'assets/google.webp',
                    height: 44,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  'assets/face.png',
                  height: 80,
                  width: 90,
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  'assets/twitter.png',
                  height: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don`t have an account?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/SignUp');
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

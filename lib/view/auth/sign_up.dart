import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/modal/user_model.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/cloud_firestrore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/google_auth_service.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 160),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Create your Account',
                  style: GoogleFonts.exo2(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            TextField(
              controller: controller.txtName,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            TextField(
              controller: controller.txtEmail,
              cursorColor: Colors.grey,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            TextField(
              controller: controller.txtPassword,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            TextField(
              controller: controller.txtConfirm,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            GestureDetector(
              onTap: () {
                if (controller.txtPassword.text == controller.txtConfirm.text) {
                  AuthService.authService.createAccountWithEmailAndPassword(
                      controller.txtEmail.text, controller.txtPassword.text);

                  UserModel user = UserModel(
                    name: controller.txtName.text,
                    email: controller.txtEmail.text,
                    image: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-avatar-image-for-profile-png-image_13001882.png",
                    token:  "---",
                  );

                  CloudFireStoreService.cloudFireStoreService
                      .insertUserIntoFireStore(user);

                  Get.back();
                  controller.txtEmail.clear();
                  controller.txtName.clear();
                  controller.txtPassword.clear();
                  controller.txtConfirm.clear();
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
                    'Sign up',
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
              '- Or sign up with -',
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
                    await GoogleAuthService.googleAuthService
                        .signInWithGoogle();
                    User? user = AuthService.authService.getCurrentUser();
                    if (user != null) {
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
          ],
        ),
      ),
    );
  }
}

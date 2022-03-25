import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movieapp/pages/main_page.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  _snackBar(String desc) {
    Get.snackbar("Error", desc,
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  }

  _register() async {
    loading = true;
    bool error = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      error = true;
      if (e.code == 'weak-password') {
        _snackBar("Weak Password");
      } else if (e.code == 'email-already-in-use') {
        _snackBar("Email Already in User");
      }
    } catch (e) {
      error = true;
      _snackBar(e.toString());
    } finally {
      loading = false;
      if (!error) {
        _login();
      } else {
        setState(() {});
      }
    }
  }

  _login() async {
    loading = true;
    setState(() {});
    bool error = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      error = true;
      if (e.code == 'user-not-found') {
        //Get.snackbar("Error", "User Not Found",backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);
        _register();
      } else if (e.code == 'wrong-password') {
        _snackBar("Wrong Password");
      } else {
        _snackBar(e.code);
      }
    } finally {
      loading = false;
      if (!error) {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          _snackBar("Please check your email");
          setState(() {});
        } else {
          Get.off(() => MainPage());
        }
      } else {
        setState(() {});
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  _loginGoogle() async {
    await signInWithGoogle();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.off(() => MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie App")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password")),
          const SizedBox(
            height: 14,
          ),
          loading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Text("Register/Login")),
          ElevatedButton(
              onPressed: () {
                _loginGoogle();
              },
              child: const Text("Login with Google"))
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:octify/views/auth/social/facebook/login.dart';

class FacebookButton extends StatefulWidget {
  @override
  _FacebookButtonState createState() => _FacebookButtonState();
}

class _FacebookButtonState extends State<FacebookButton> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isSigningIn = false; // State variable for loading

  Future<User?> _signIn(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign in button clicked')),
    );

    try {
      // Trigger the Facebook login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Get the access token
        final AccessToken accessToken = result.accessToken!;
        // Create a credential for Firebase
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        // Sign in to Firebase
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final User user = userCredential.user!;

        ProviderDetails userInfo = ProviderDetails(
          user.uid,
          user.displayName ?? '',
          user.photoURL ?? '',
          user.email ?? '',
          user.emailVerified.toString(),
        );

        List<ProviderDetails> providerData = [userInfo];

        UserInfoDetails userInfoDetails = UserInfoDetails(
          user.providerData[0].providerId,
          user.uid,
          user.displayName ?? '',
          user.photoURL ?? '',
          user.email ?? '',
          user.isAnonymous,
          user.emailVerified,
          providerData,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedScreen(detailsUser: userInfoDetails),
          ),
        );

        return user;
      } else {
        print("Facebook login failed: ${result.message}");
        return null;
      }
    } catch (e) {
      print("Error during Facebook login: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isSigningIn = true;
        });

        User? user = await _signIn(context);

        setState(() {
          _isSigningIn = false;
        });

        if (user != null) {
          print('Signed in: ${user.displayName}');
        }
      },
      child: Container(
        height: 51,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff1877F2) // Facebook Blue
              : const Color(0xff1877F2), // Facebook Blue
          borderRadius: BorderRadius.circular(16),
        ),
        child: _isSigningIn
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.facebook,
                    size: 24,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Sign in with Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class UserInfoDetails {
  UserInfoDetails(
    this.providerId,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.email,
    this.isAnonymous,
    this.isEmailVerified,
    this.providerData,
  );

  final String providerId;
  final String uid;
  final String displayName;
  final String photoUrl;
  final String email;
  final bool isAnonymous;
  final bool isEmailVerified;
  final List<ProviderDetails> providerData;
}

class ProviderDetails {
  final String providerId;
  final String uid;
  final String displayName;
  final String photoUrl;
  final String email;

  ProviderDetails(
    this.providerId,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.email,
  );
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:octify/views/auth/social/apple/view.dart';
import 'package:octify/views/auth/social/facebook/facbook_data.dart';
import 'package:octify/views/auth/social/google/auth.dart';
import 'package:octify/widgets/svg.dart';

class SignInButtons extends StatefulWidget {
  const SignInButtons({super.key});

  @override
  _SignInButtonsState createState() => _SignInButtonsState();
}

class _SignInButtonsState extends State<SignInButtons> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isSigningIn = true;
                      });
                      await Authentication.signInWithGoogle(context: context);

                      setState(() {
                        _isSigningIn = false;
                      });

                      // Navigate to the desired screen
                    },
                    child: Container(
                      height: 51,
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.transparent
                              : Colors.grey,
                        ),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xff2D2D2D)
                            : Colors.white, // Google button color: 0xFF4285F4

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customSvg(name: 'google_icon', height: 24),
                          const SizedBox(width: 10),
                          Text(
                            'sign in with google',
                          ),
                        ],
                      ),
                    )),

                const SizedBox(
                    height: 20), // Add some space between the buttons
                Platform.isIOS
                    ? GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isSigningIn = true;
                          });
                          await AppleAuthentication.signInWithApple(
                              context: context);

                          setState(() {
                            _isSigningIn = false;
                          });
                        },
                        child: Container(
                          height: 51,
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? const Color(0xff2D2D2D)
                                : Colors
                                    .black, // Google button color: 0xFF4285F4

                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.apple,
                                size: 24,
                                color: Colors
                                    .white, // Google button color: 0xFF4285F4
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'sign in with apple',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ))
                    : const SizedBox(),
                const SizedBox(height: 20),
                FacebookButton()
              ],
            ),
    );
  }
}

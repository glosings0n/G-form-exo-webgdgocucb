import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInDialogView(),
    );
  }
}

class SignInDialogView extends StatefulWidget {
  const SignInDialogView({super.key});

  @override
  State<SignInDialogView> createState() => _SignInDialogViewState();
}

class _SignInDialogViewState extends State<SignInDialogView> {
  bool isAdmin = false;
  bool isSelected = false;

  void selectWindow(bool admin) {
    setState(() {
      isSelected = !isSelected;
      isAdmin = admin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Center(
        child: Container(
          width: 500,
          height: 300,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF020817),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white10,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Rôle utilisateur",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    HugeIcons.strokeRoundedUserCircle02,
                    color: Colors.blue.shade100.withOpacity(0.5),
                    size: 20,
                  ),
                  const Gap(8),
                  Text(
                    "georgesbyona@gmail.com",
                    style: TextStyle(
                      color: Colors.blue.shade100.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Gap(25),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectWindow(false),
                        child: MainBox(
                          text: "Encadreur",
                          isSelected: !isSelected,
                          isLeft: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectWindow(true),
                        child: MainBox(
                          text: "Admin",
                          isSelected: isSelected,
                          isLeft: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isAdmin
                  ? Column(
                      children: [
                        const Gap(20),
                        Text(
                          "Vous êtes sur le point de vous connecter en tant qu'administrateur. Veuillez confirmer votre action.",
                          style: TextStyle(
                            color: Colors.blue.shade100.withOpacity(0.5),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(20),
                      ],
                    )
                  : const Column(
                      children: [
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Année académique",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Gap(5),
                        Text(
                          "Chargement des données ...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Gap(15),
                      ],
                    ),
              Container(
                alignment: Alignment.center,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF3576DF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Continuer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A195B),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MainBox extends StatelessWidget {
  const MainBox({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isLeft,
  });

  final String text;
  final bool isSelected;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue.shade100.withOpacity(0.2),
        borderRadius: isLeft
            ? const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
      ),
      child: isSelected
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFF020817),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: Colors.blue.shade100.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
    );
  }
}

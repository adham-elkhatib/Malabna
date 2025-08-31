//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../authentication/presentation/pages/landing.screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class ProfileScreen extends StatefulWidget {
  //SECTION - Widget Arguments

  //!SECTION
  //
  const ProfileScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  AppUser? appUser;
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  //t2 --Controllers
  //
  //t2 --State

  //t2 --State
  //
  //t2 --Constants
  final _formKey = GlobalKey<FormState>();

  //t2 --Constants
  //!SECTION

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    //t2 --Controllers & Listeners
    //
    //t2 --State
    String? userId = AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    ).getCurrentUserId();

    if (userId != null) {
      AppUserRepo().readSingle(userId).then((value) {
        setState(() {
          appUser = value;
          _fNameController.text = "${appUser?.fName}";
          _lNameController.text = "${appUser?.lName}";
          _emailController.text = "${appUser?.email}";
          _phoneNumberController.text = "${appUser?.phoneNumber}";
        });
      });
    }

    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  //SECTION - Stateless functions
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION
  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("حسابي"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () async {
                  await AuthService(
                    authProvider: FirebaseAuthProvider(
                        firebaseAuth: FirebaseAuth.instance),
                  ).signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LandingScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ))
          ],
        ),
        body: appUser != null
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SectionTitle(title: "تفاصيل الحساب"),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _fNameController,
                        decoration: const InputDecoration(
                          hintText: "الاسم الأول",
                          labelText: "الاسم الأول",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لا يمكن أن يكون الاسم الكامل فارغًا';
                          } else if (value.length < 3) {
                            return 'الاسم الكامل يجب أن يتكون من 3 أحرف على الأقل';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        // readOnly: true,
                        enabled: false,
                        decoration: const InputDecoration(
                          hintText: "البريد الإلكتروني",
                          labelText: "البريد الإلكتروني",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SectionTitle(title: "معلومات شخصية"),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          hintText: "رقم الهاتف",
                          labelText: "رقم الهاتف",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال رقم هاتفك';
                          }
                          if (!RegExp(r'^05\d{8}$').hasMatch(value)) {
                            return 'يجب أن يبدأ رقم الهاتف بـ "05" ويتكون من 10 أرقام';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 42),
          child: PrimaryButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                appUser?.fName = _fNameController.text;
                appUser?.email = _emailController.text;
                appUser?.phoneNumber = _phoneNumberController.text;

                await AppUserRepo().updateSingle(appUser!.id, appUser!);
                SnackBar snackbar = SnackBar(
                  content: Text(
                    "تم تحديث ملفك الشخصي بنجاح!",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  backgroundColor: const Color(0xFF4CAF50),
                  behavior: SnackBarBehavior.floating,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 6,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Navigator.pop(context);
              }
            },
            color: Theme.of(context).colorScheme.primary,
            title: 'حفظ',
          ),
        ),
      ),
    );
    //!SECTION
  }
}

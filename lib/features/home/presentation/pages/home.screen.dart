//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Model/Match/match.model.dart';
import '../../../../Data/Repositories/match.repo.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../match_details/presentation/pages/match_details_screen.dart';
import '../../../profile/presentation/pages/profile.screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class HomeScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const HomeScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  AppUser? appUser;
  List<Match?> matches = [];
  bool isLoading = true;
  List<Match?> filteredMatches = [];
  String searchText = "";

  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION
  @override
  void initState() {
    super.initState();

    // SECTION - State Variables Initializations & Listeners

    // Initialize state variables
    // Check if a user is currently signed in
    String? userId = AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    ).getCurrentUserId();

    if (userId != null) {
      AppUserRepo().readSingle(userId).then((value) {
        setState(() {
          appUser = value;
        });
      }).then(
        (_) => MatchesRepo().readAll().then(
          (value) {
            setState(
              () {
                if (value != null) {
                  matches = value;
                  filteredMatches = value;
                }
                isLoading = false;
              },
            );
          },
        ),
      );
    }

    // Load matches data

    // END SECTION
  }

  //SECTION - Stateless functions
  //!SECTION
  //SECTION - Action Callbacks
  //!SECTION
  void filterMatches(String query) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        filteredMatches = matches;
      } else {
        filteredMatches = matches.where((match) {
          return match!.firstTeam.contains(query) ||
              match.secondTeam.contains(query);
        }).toList();
      }
    });
  }

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
          title: const Text('الصفحة الرئيسية'),
          actions: appUser != null
              ? [
                  IconButton(
                    icon: Icon(
                      Icons.person_2_outlined,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ]
              : [],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: filterMatches,
                decoration: InputDecoration(
                  hintText: 'بحث عن فريق...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SectionTitle(title: "المباريات القادمة"),
                    filteredMatches.isNotEmpty
                        ? Column(
                            children: List.generate(
                              filteredMatches.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          MatchDetailsScreen(
                                        match: filteredMatches[index]!,
                                      ),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                        filteredMatches[index]!.imageUrl),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text("لا يوجد مباريات قادمة"),
                          ),
                  ],
                ),
              ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}

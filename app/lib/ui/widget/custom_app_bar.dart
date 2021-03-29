import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

customAppBar(
        {required String leftButtonText,
        required String centreButtonText,
        required String rightButtonText,
        required VoidCallback leftButtonAction,
        required VoidCallback centreButtonAction,
        required VoidCallback rightButtonAction}) =>
    PreferredSize(
        preferredSize: Size.fromHeight(175.0),
        child: _CustomAppBarInner(
          leftButtonText: leftButtonText,
          centreButtonText: centreButtonText,
          rightButtonText: rightButtonText,
          leftButtonAction: leftButtonAction,
          centreButtonAction: centreButtonAction,
          rightButtonAction: rightButtonAction,
        ));

class _CustomAppBarInner extends StatefulWidget {
  final FirebaseAuthService _firebaseAuthService =
      ServiceLocator.get<FirebaseAuthService>();
  final FirebaseDatabaseService _databaseService =
      ServiceLocator.get<FirebaseDatabaseService>();
  final String leftButtonText;
  final String centreButtonText;
  final String rightButtonText;
  final VoidCallback leftButtonAction;
  final VoidCallback centreButtonAction;
  final VoidCallback rightButtonAction;

  _CustomAppBarInner(
      {Key? key,
      required this.leftButtonText,
      required this.centreButtonText,
      required this.rightButtonText,
      required this.leftButtonAction,
      required this.centreButtonAction,
      required this.rightButtonAction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomAppBarInnerState();
}

class _CustomAppBarInnerState extends State<_CustomAppBarInner> {
  // TODO: Move this stream into ViewModel.
  // Need the view model to listen infinitely for changes.
  StreamSubscription<User?>? _currentUserSubscription;
  bool isAdmin = false;

  @override
  void initState() {
    final thisUser = widget._firebaseAuthService.currentUser;
    if (thisUser != null) {
      widget._databaseService
          .getAccount(thisUser.uid)
          .then((Account account) => setState(() => isAdmin = account.isAdmin))
          .catchError((error) => setState(() => isAdmin = false));
    }
    _currentUserSubscription =
        widget._firebaseAuthService.currentUserChanges.listen((User? user) {
      if (user != null) {
        widget._databaseService
            .getAccount(user.uid)
            .then(
                (Account account) => setState(() => isAdmin = account.isAdmin))
            .catchError((error) => setState(() => isAdmin = false));
      } else {
        setState(() => isAdmin = false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_currentUserSubscription != null) _currentUserSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: isAdmin ? IndependencePurple : BurntSienna,
        child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isAdmin
                        ? [
                            IndependencePurple,
                            TerraCottaPink,
                          ]
                        : [
                            BurntSienna,
                            SandyBrown,
                          ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40.0)),
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 75.0,
                    ),
                    Flexible(
                        child: Text(
                      'Community of Meal Planners Forums',
                      style: GoogleFonts.cabin(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: LargeTextSize),
                    )),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: isAdmin ? TerraCottaPink : PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: widget.leftButtonText,
                      onPressed: widget.leftButtonAction,
                      color: Colors.white),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: isAdmin ? TerraCottaPink : PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: widget.centreButtonText,
                      onPressed: widget.centreButtonAction,
                      color: Colors.white),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: isAdmin ? TerraCottaPink : PersianGreenOpaque,
                      border: Border.all(color: Colors.white)),
                  child: textButton(
                      text: widget.rightButtonText,
                      onPressed: widget.rightButtonAction,
                      color: Colors.white),
                ))
              ]),
              if (isAdmin == true)
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: IndependencePurple,
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          "ADMINISTRATION",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cabin(
                              color: Colors.white, fontSize: LargeTextSize),
                        ),
                      ))
                    ])
            ])));
  }
}

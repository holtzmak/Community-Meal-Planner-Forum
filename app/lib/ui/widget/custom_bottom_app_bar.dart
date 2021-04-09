import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/about_and_legal_view_model.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar._internal();

  static CustomBottomAppBar get() => CustomBottomAppBar._internal();

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<AboutAndLegalViewModel>(
      builder: (context, model, child) => Container(
        height: 75.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              PersianGreen,
              Charcoal,
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.white,
              size: 45.0,
            ),
            title: textButton(
                text: "About this application",
                onPressed: model.navigateToAboutAndLegalScreen,
                color: Colors.white),
            // Creative Commons Attribution-ShareAlike 4.0 International License
            trailing: Image(image: AssetImage('assets/cc-by-sa-4.0.png')),
          ),
        ),
      ),
    );
  }
}

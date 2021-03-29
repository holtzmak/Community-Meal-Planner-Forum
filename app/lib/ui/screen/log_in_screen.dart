import 'package:app/service/validator_service.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/log_in_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  static const route = '/login';
  final _formKey = GlobalKey<FormState>();

  bool validate() => _formKey.currentState!.validate();

  LogInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit(LogInViewModel model) {
    if (widget.validate()) {
      model.login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<LogInViewModel>(
        builder: (context, model, child) => Scaffold(
              appBar: customAppBar(
                  leftButtonText: "Signup",
                  centreButtonText: "Home",
                  rightButtonText: "FAQ",
                  leftButtonAction: model.navigateToSignUpScreen,
                  centreButtonAction: model.navigateToHomeScreen,
                  rightButtonAction: () {
                    // TODO
                  }),
              bottomNavigationBar: CustomBottomAppBar.get(),
              body: SingleChildScrollView(
                  child: Form(
                key: widget._formKey,
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '''This is an application for meal planners, educators, sustainability practicers, educators, and more!''',
                            style: GoogleFonts.raleway(
                                color: Charcoal, fontSize: MediumTextSize),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login',
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                color: Charcoal,
                                fontSize: LargeTextSize),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Your email?"),
                          validator: ValidatorService.emailValidator,
                          decoration: InputDecoration(
                              errorStyle:
                                  GoogleFonts.notoSerif(color: BurntSienna),
                              border: OutlineInputBorder(),
                              labelText: "Your email?"),
                          controller: _emailController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Your password?"),
                          obscureText: true,
                          validator: ValidatorService.passwordValidator,
                          decoration: InputDecoration(
                              errorStyle:
                                  GoogleFonts.notoSerif(color: BurntSienna),
                              border: OutlineInputBorder(),
                              labelText: "Your password?"),
                          controller: _passwordController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.5,
                          ),
                        ),
                        ButtonBar(
                          buttonPadding: EdgeInsets.only(left: 20.0),
                          children: [
                            elevatedButton(
                                text: "Login",
                                onPressed: () => _validateAndSubmit(model),
                                color: BurntSienna,
                                pressedColor: BurntSiennaOpaque),
                            outlinedButton(
                                text: "New? Signup!",
                                onPressed: model.navigateToSignUpScreen,
                                color: Charcoal)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
            ));
  }
}

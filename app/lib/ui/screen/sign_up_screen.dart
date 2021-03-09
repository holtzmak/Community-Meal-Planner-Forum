import 'package:app/service/validator_service.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/sign_up_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/form/dynamic_form_field.dart';
import 'package:app/ui/widget/form/string_dynamic_form_field.dart';
import 'package:app/ui/widget/form/string_form_field.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  static const route = '/signup';
  final formKey = GlobalKey<FormState>();

  SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  List<String> _titles = [];
  late DynamicFormField<String, StringFormField> _titlesFormField;
  final _aboutMeDescController = TextEditingController();

  @override
  void initState() {
    _titlesFormField = dynamicStringFormField(
        initialList: _titles,
        titles: "Title",
        onSaved: (List<String> changed) => _titles = changed);
    super.initState();
  }

  void _validateAndSave(SignUpViewModel model) {
    if (widget.formKey.currentState!.validate() &&
        _titlesFormField.formKey.currentState!.validate()) {
      _titlesFormField.formKey.currentState!.save();
      model.signUp(
          name: _nameController.text.trim(),
          titles: _titles,
          aboutMeDescription: _aboutMeDescController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<SignUpViewModel>(
        builder: (context, model, child) => Scaffold(
              appBar: CustomAppBar.get(),
              body: SingleChildScrollView(
                  child: Form(
                key: widget.formKey,
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '''This is an application for meal planners, educators, sustainability practicers, educators, and more!\n\nBy signing up, you agree to our Terms of Service and Privacy Policy.''',
                            style: GoogleFonts.raleway(
                                color: IndependencePurple,
                                fontSize: MediumTextSize),
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
                            'Signup',
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                color: IndependencePurple,
                                fontSize: LargeTextSize),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Your display name?"),
                          validator: ValidatorService.emptyValidator,
                          decoration: InputDecoration(
                              errorStyle:
                                  GoogleFonts.roboto(color: TerraCottaPink),
                              border: OutlineInputBorder(),
                              labelText: "Your display name?"),
                          controller: _nameController,
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
                                  GoogleFonts.roboto(color: TerraCottaPink),
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
                          validator: ValidatorService.passwordValidator,
                          decoration: InputDecoration(
                              errorStyle:
                                  GoogleFonts.roboto(color: TerraCottaPink),
                              border: OutlineInputBorder(),
                              labelText: "Your password?"),
                          controller: _passwordController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        Text(
                          "Add some titles for yourself if you like!",
                          style: GoogleFonts.roboto(color: IndependencePurple),
                        ),
                        _titlesFormField,
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Describe yourself"),
                          decoration: InputDecoration(
                              errorStyle:
                                  GoogleFonts.roboto(color: TerraCottaPink),
                              border: OutlineInputBorder(),
                              labelText: "Describe yourself"),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          controller: _aboutMeDescController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.5,
                          ),
                        ),
                        ButtonBar(
                          children: [
                            elevatedButton(
                                text: "Signup",
                                onPressed: () => _validateAndSave(model),
                                color: GreenSheen,
                                pressedColor: GreenSheenOpaque),
                            outlinedButton(
                                text: "Have an account? Login!",
                                onPressed: model.navigateToSignInScreen,
                                color: IndependencePurple)
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

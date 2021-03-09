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

  // TODO: Extract validators into their own service
  String? emptyFieldValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else
      return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be at least 6 characters";
    } else if (value.length > 10) {
      return "Password should not be greater than 10 characters";
    } else
      return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '* Required';
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return '* Please enter a valid Email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<SignUpViewModel>(
        builder: (context, model, child) => Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(175.0), child: CustomAppBar()),
              body: SingleChildScrollView(
                  child: Form(
                key: widget.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.all(5.0)),
                        Text(
                          'Signup',
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(61, 64, 91, 1),
                              fontSize: 24),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 40.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Your display name?"),
                          validator: emptyFieldValidation,
                          decoration: InputDecoration(
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
                          validator: validateEmail,
                          decoration: InputDecoration(
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
                          validator: validatePassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Your password?"),
                          controller: _passwordController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        _titlesFormField,
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.5,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Describe yourself"),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Describe yourself"),
                          controller: _aboutMeDescController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.5,
                          ),
                        ),
                        TextButton(
                          child: Text('Already have an account?'),
                          onPressed: () => model.navigateToSignInScreen(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        ButtonBar(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (widget.formKey.currentState!.validate()) {
                                  model.signUp(
                                      name: _nameController.text.trim(),
                                      titles: _titles,
                                      aboutMeDescription:
                                          _aboutMeDescController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());
                                }
                              },
                              child: Text("Signup"),
                            ),
                            OutlinedButton(
                              onPressed: () => model.navigateToSignInScreen(),
                              child: Text("Already have an account? Login"),
                            )
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

import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/splash_screen.dart';
import 'package:pureride/utils/auth.dart';

class LoginSignUpScreen extends StatefulWidget {
  LoginSignUpScreen({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginSignUpScreenState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _errorMessage = "";

  FormMode _formMode = FormMode.LOGIN;
  bool _isIos = false;
  bool _isLoading = false;

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 &&
            userId != null &&
            _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  InputDecoration _inputFormat(String hintText, IconData icon) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        icon: Icon(
          icon,
          color: Colors.grey,
        ));
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: _inputFormat("Email", Icons.email),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: _inputFormat("Password", Icons.lock),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget _showPrimaryButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Color(0xFFFE4F1F),
          child: _formMode == FormMode.LOGIN
              ? Text('Login',
                  style: TextStyle(fontSize: 20.0, color: Colors.white))
              : Text('Create account',
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: _validateAndSubmit,
        ));
  }

  Widget _showSecondaryButton() {
    return FlatButton(
      child: _formMode == FormMode.LOGIN
          ? Text('Create an account',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : Text('Have an account? Sign in',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget _showBody() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
        body: Container(
      decoration: buildBackground(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildText(context),
            Stack(
              children: <Widget>[
                _showBody(),
                _showCircularProgress(),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

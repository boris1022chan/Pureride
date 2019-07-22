import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/google_sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BoxDecoration _buildBackground() {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/intersection.jpeg"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.9), BlendMode.dstATop),
        ),
      );
    }

    Text _buildText() {
      return Text(
        'PureRide',
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      body: Container(
        decoration: _buildBackground(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildText(),
              SizedBox(height: 50.0),
              GoogleSignInButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/')),
            ],
          ),
        ),
      ),
    );
  }
}

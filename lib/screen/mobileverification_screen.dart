import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen/newpassword_screen.dart'; // Import the NewpasswordScreen

class MobileVerificationScreen extends StatefulWidget {
  @override
  _MobileVerificationScreenState createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  final int _codeLength = 4;
  List<TextEditingController> _codeControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  void _verifyCode() {
    String code = '';
    for (TextEditingController controller in _codeControllers) {
      code += controller.text;
    }
    if (code.length == _codeLength) {
      // Navigate to the NewpasswordScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewpasswordScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the 4-digit code')),
      );
    }
  }

  void _resendCode() {
    // Add your resend code logic here
    // For example, call an API to resend the code
    print('Resend code');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Mobile Phone Verification',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildVerificationMessage(),
              SizedBox(height: 24.0),
              _buildCodeInputField(),
              SizedBox(height: 24.0),
              _buildVerifyButton(),
              SizedBox(height: 16.0),
              _buildResendButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationMessage() {
    return Text(
      'Enter the 4-digit verification code',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCodeInputField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        _codeLength,
        (index) {
          return SizedBox(
            width: 50.0,
            child: TextField(
              controller: _codeControllers[index],
              textAlign: TextAlign.center,
              maxLength: 1,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                counterText: '', // Hides the counter
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
              ),
              onChanged: (value) {
                // If the value is empty and it's not the first input field, remove the focus
                if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    return ElevatedButton(
      onPressed: _verifyCode,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        'Verify ',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _buildResendButton() {
    return TextButton(
      onPressed: _resendCode,
      child: Text(
        'Didn\'t receive code? Resend',
        style: TextStyle(color: Colors.orangeAccent),
      ),
    );
  }
}

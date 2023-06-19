import 'package:flutter/material.dart';
import 'package:tiktok/views/screens/auth/login_screen.dart';

import '../../../constants.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import '../../widgets/text_input_field.dart';



class SignupScreen extends StatelessWidget {
   SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();
   final TextEditingController _usernameController= TextEditingController();


     @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AmeoTok',
              style: TextStyle(
                fontSize: 35,
                color: buttonColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text('Register', style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            ),
            const SizedBox(height: 15,),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                    'https://images.moneycontrol.com/static-mcnews/2023/02/FNP-Heart-In-A-Box-Rose-Arrangements-Rs-1399-1-770x433.jpg?impolicy=website&width=770&height=431',),
                  backgroundColor: Colors.black,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () =>authController.pickImage(),
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _usernameController,
                labelText: 'User Name',
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 15,
            ),
           Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            const SizedBox(height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
              ),
              child: InkWell(
                onTap: () => authController.registerUser(_usernameController.text, _emailController.text, _passwordController.text,
                    authController.profilePhoto),
                 child: const Center(
                  child: Text('Register', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: (){
                    _navigateToNextScreen(context);
                    print('Register user');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20,color: buttonColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginScreen()));
}
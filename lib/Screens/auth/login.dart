import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isObScureText = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Image.asset("assets/images/logo.png", width: 80),),
                const Text("Sign In", style: TextStyle(color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.bold),),
                const SizedBox(height: 15),
                TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email, color: AppColors.primaryColor,),
                      filled: true,
                      fillColor: AppColors.lightBlue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  obscureText: _isObScureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor,),
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            _isObScureText = !_isObScureText;
                          });
                        },
                        child: Icon(_isObScureText ? Icons.visibility : Icons.visibility_off)
                        ),
                      filled: true,
                      fillColor: AppColors.lightBlue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
                      ),
                    ),
                  ),
                Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const Text("Remember Me", style: TextStyle(color: AppColors.primaryColor),),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 16, color: AppColors.lightBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text("I don’t have an account, ", 
                        style: TextStyle(
                          color: AppColors.primaryColor
                          ),
                          ),
                        TextButton(onPressed: (){
                        
                        }, 
                        child: const Text("Sign Up",style: TextStyle(
                            color: Color(0xFF0052A6),
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                          )
                        )
                      ],
                    ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
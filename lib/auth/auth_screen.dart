import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isLoginFormVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.89, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleForms() {
    setState(() {
      _isLoginFormVisible = !_isLoginFormVisible;
    });
    if (_isLoginFormVisible) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundImage(context),
          buildForm(),
        ],
      ),
    );
  }

  Widget buildForm() {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isLoginFormVisible) ...[
                    const CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  if (!_isLoginFormVisible) ...[
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Phone',
                        prefixIcon: Icon(Icons.phone, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        prefixIcon:
                            Icon(Icons.calendar_today, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  if (!_isLoginFormVisible) ...[
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, perform login or signup logic
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text(_isLoginFormVisible ? 'Sign In' : 'Sign Up'),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: _toggleForms,
                    child: Text(
                      _isLoginFormVisible ? 'Sign Up' : 'Sign In',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackgroundImage(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      crossFadeState: _isLoginFormVisible
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: Image.asset(
        'assets/backGround-image.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        key: const ValueKey<String>('img1'),
        fit: BoxFit.cover,
      ),
      secondChild: Image.asset(
        'assets/skills.jpeg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        key: const ValueKey<String>('img2'),
        fit: BoxFit.cover,
      ),
    );
  }
}

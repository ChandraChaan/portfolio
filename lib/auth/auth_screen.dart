import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isLoginFormVisible = true;
  final _formKey = GlobalKey<FormState>();
  Artboard? _riveArtboard;
  RiveAnimationController? _animationController;

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
    _loadRiveFile();
  }

  void _loadRiveFile() async {
    try {
      final bytes = await rootBundle.load('assets/rive/teddy_bear.riv');
      final file = RiveFile.import(bytes);

      setState(() {
        _riveArtboard = file.mainArtboard;
        _animationController = SimpleAnimation('idle');
        _riveArtboard!.addController(_animationController!);
      });
    } catch (e) {
      print('Error loading Rive file: $e');
    }
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
                    if (_riveArtboard != null)
                      SizedBox(
                        height: 190,
                        child: RiveAnimation.asset(
                          'assets/rive/teddy_bear.riv',
                          artboard: _riveArtboard!.name,
                          controllers: [_animationController!],
                        ),
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
                    onChanged: (value) {
                      if (_riveArtboard != null) {
                        if (value.isNotEmpty) {
                          _animationController?.isActive = false;
                          _animationController = SimpleAnimation('look_down');
                          _animationController?.isActive = true;
                        } else {
                          _animationController?.isActive = false;
                          _animationController = SimpleAnimation('idle');
                          _animationController?.isActive = true;
                        }
                      }
                    },
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
                        prefixIcon: Icon(Icons.calendar_today, color: Colors.white),
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
                    onChanged: (value) {
                      if (_riveArtboard != null) {
                        if (value.isNotEmpty) {
                          _animationController?.isActive = false;
                          _animationController = SimpleAnimation('hands_up');
                          _animationController?.isActive = true;
                        } else {
                          _animationController?.isActive = false;
                          _animationController = SimpleAnimation('idle');
                          _animationController?.isActive = true;
                        }
                      }
                    },
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
      secondChild: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        key: const ValueKey<String>('img2'),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: RiveAnimation.asset(
                'assets/rive/teddy_bear.riv',
                artboard: _riveArtboard!.name,
                controllers: [_animationController!],
              ),
            ),
            const Expanded(
              flex: 4,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}


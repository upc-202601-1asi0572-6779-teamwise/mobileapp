import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_theme.dart';
import '../../../../smartpalm_tokens.dart';
import '../../../auth/presentation/providers/AuthProvider.dart';
import '../../../core/providers/NavigationProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final success = await auth.signIn(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;
    if (success) {
      context.read<NavigationProvider>().switchTab(0);
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isLoading = auth.status == AuthStatus.loading;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: SPColors.loginGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: SPSpacing.x3l),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo-emblem.png', height: 88),
                    const SizedBox(height: SPSpacing.x3l),
                    Text('Smart Palm', style: SPType.heroWhite),
                    const SizedBox(height: SPSpacing.xs),
                    Text(
                      'Monitoreo inteligente de cultivos',
                      style: SPType.caption.copyWith(color: const Color(0x99FFFFFF)),
                    ),
                    const SizedBox(height: SPSpacing.x5l),
                    TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: spDarkInputDecoration(label: 'Usuario'),
                      textInputAction: TextInputAction.next,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Ingresa tu usuario' : null,
                    ),
                    const SizedBox(height: SPSpacing.lg),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: spDarkInputDecoration(label: 'Contraseña').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: const Color(0x80FFFFFF),
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Ingresa tu contraseña' : null,
                    ),
                    const SizedBox(height: SPSpacing.x3l),
                    if (auth.status == AuthStatus.error)
                      Padding(
                        padding: const EdgeInsets.only(bottom: SPSpacing.lg),
                        child: Text(
                          auth.errorMessage,
                          style: SPType.bodySmall.copyWith(color: SPColors.crit),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    FilledButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Ingresar'),
                    ),
                    const SizedBox(height: SPSpacing.x3l),
                    Text(
                      'Tu cuenta es creada por el administrador de tu cultivo.\nSi no tienes credenciales, contáctalo.',
                      style: SPType.caption.copyWith(color: const Color(0x80FFFFFF)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

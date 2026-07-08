import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../smartpalm_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_loading) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _goOffline() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: SPColors.headerGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: SPSpacing.xl, vertical: SPSpacing.x3l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                _Logo(),
                const SizedBox(height: 40),
                _Card(
                  emailCtrl: _emailCtrl,
                  passCtrl: _passCtrl,
                  obscure: _obscure,
                  loading: _loading,
                  onToggleObscure: () =>
                      setState(() => _obscure = !_obscure),
                  onLogin: _login,
                  onOffline: _goOffline,
                ),
                const SizedBox(height: 24),
                _OfflineBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0x1FFFFFFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x33FFFFFF), width: 1.5),
        ),
        child: const Icon(Icons.eco, color: Colors.white, size: 44),
      ),
      const SizedBox(height: 14),
      Text('SmartPalm',
          style: SPType.hero.copyWith(color: Colors.white, fontSize: 30)),
      const SizedBox(height: 4),
      Text('Monitoreo IoT · Palma Aceitera',
          style: SPType.caption.copyWith(color: const Color(0xCCFFFFFF))),
    ]);
  }
}

class _Card extends StatelessWidget {
  final TextEditingController emailCtrl, passCtrl;
  final bool obscure, loading;
  final VoidCallback onToggleObscure, onLogin, onOffline;
  const _Card({
    required this.emailCtrl, required this.passCtrl,
    required this.obscure, required this.loading,
    required this.onToggleObscure, required this.onLogin,
    required this.onOffline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: SPShadows.card,
      ),
      padding: const EdgeInsets.all(SPSpacing.x2l),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Iniciar sesión',
            style: SPType.hero.copyWith(
                color: SPColors.text, fontSize: 22)),
        const SizedBox(height: 4),
        Text('Ingresa tus credenciales para continuar',
            style: SPType.caption.copyWith(color: SPColors.muted)),
        const SizedBox(height: SPSpacing.x2l),
        TextField(
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: spDarkInputDecoration(
            label: 'Correo electrónico',
            hint: 'usuario@fundo.com',
          ).copyWith(
            prefixIcon: const Icon(Icons.mail_outline,
                size: 18, color: SPColors.muted),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: passCtrl,
          obscureText: obscure,
          decoration: spDarkInputDecoration(
            label: 'Contraseña',
            hint: '••••••••',
          ).copyWith(
            prefixIcon: const Icon(Icons.lock_outline,
                size: 18, color: SPColors.muted),
            suffixIcon: IconButton(
              icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  size: 18, color: SPColors.muted),
              onPressed: onToggleObscure,
            ),
          ),
        ),
        const SizedBox(height: SPSpacing.xl),
        FilledButton(
          onPressed: loading ? null : onLogin,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
          child: loading
              ? const SizedBox(
              width: 22, height: 22,
              child: CircularProgressIndicator(
                  strokeWidth: 2.5, color: Colors.white))
              : const Text('Ingresar'),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: onOffline,
          child: Text('Continuar sin conexión',
              style: SPType.body.copyWith(color: SPColors.primary)),
        ),
      ]),
    );
  }
}

class _OfflineBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0x26FFFFFF),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: const Color(0x33FFFFFF)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.wifi_off, color: Colors.white70, size: 14),
          const SizedBox(width: 6),
          Text('Modo sin conexión disponible',
              style: SPType.caption.copyWith(color: Colors.white70)),
        ]),
      ),
    );
  }
}

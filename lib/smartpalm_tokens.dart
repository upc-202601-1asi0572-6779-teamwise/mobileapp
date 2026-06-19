import 'package:flutter/material.dart';

// ─── Colores ─────────────────────────────────────────────────────────────────

class SPColors {
  SPColors._();

  static const Color primary     = Color(0xFF22C55E);
  static const Color primaryDark = Color(0xFF166534);
  static const Color primaryMid  = Color(0xFF14532D);

  static const Color bg          = Color(0xFFF0FDF4);
  static const Color card        = Color(0xFFFFFFFF);
  static const Color dbg         = Color(0xFF0F172A);

  static const Color text        = Color(0xFF0F172A);
  static const Color body        = Color(0xFF374151);
  static const Color muted       = Color(0xFF9CA3AF);

  static const Color border      = Color(0xFFE5E7EB);

  static const Color crit        = Color(0xFFEF4444);
  static const Color warn        = Color(0xFFEAB308);
  static const Color info        = Color(0xFF3B82F6);
  static const Color ok          = Color(0xFF22C55E);

  static const Color teal        = Color(0xFF14B8A6);
  static const Color amber       = Color(0xFFF59E0B);

  static const Color softGreen   = Color(0xFFD1FAE5);
  static const Color softRed     = Color(0xFFFEE2E2);
  static const Color softYellow  = Color(0xFFFEF9C3);
  static const Color softBlue    = Color(0xFFEFF6FF);

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primaryMid],
  );

  static const LinearGradient loginGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDark, dbg],
  );
}

// ─── Tipografía ───────────────────────────────────────────────────────────────

class SPType {
  SPType._();

  static const String fontFamily = 'Roboto';

  static const TextStyle hero = TextStyle(
    fontFamily: fontFamily, fontSize: 28, fontWeight: FontWeight.w500, height: 1.2,
  );
  static const TextStyle sectionHeading = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500, height: 1.3,
  );
  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily, fontSize: 15, fontWeight: FontWeight.bold, height: 1.3,
  );
  static const TextStyle metricValue = TextStyle(
    fontFamily: fontFamily, fontSize: 28, fontWeight: FontWeight.bold, height: 1.1,
  );
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.normal, height: 1.5,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily, fontSize: 13, fontWeight: FontWeight.normal, height: 1.4,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.normal, height: 1.4,
  );
  static const TextStyle tag = TextStyle(
    fontFamily: fontFamily, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.2,
  );
  static const TextStyle tabLabel = TextStyle(
    fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.normal,
  );
  static const TextStyle tabLabelActive = TextStyle(
    fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.bold,
  );
  static const TextStyle eyebrow = TextStyle(
    fontFamily: fontFamily, fontSize: 11, fontWeight: FontWeight.normal,
    letterSpacing: 0.8,
  );

  static TextStyle withColor(TextStyle base, Color color) => base.copyWith(color: color);

  static TextStyle get heroWhite    => hero.copyWith(color: Colors.white);
  static TextStyle get captionMuted => caption.copyWith(color: SPColors.muted);
  static TextStyle get bodyText     => body.copyWith(color: SPColors.text);
  static TextStyle get tagPrimary   => tag.copyWith(color: SPColors.primary);
}

// ─── Espaciado (grilla 4dp) ───────────────────────────────────────────────────

class SPSpacing {
  SPSpacing._();

  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 12;
  static const double m   = 14;
  static const double lg  = 16;
  static const double xl  = 18;
  static const double x2l = 20;
  static const double x3l = 24;
  static const double x4l = 28;
  static const double x5l = 32;
  static const double x6l = 48;

  static const EdgeInsets cardPadding = EdgeInsets.all(14);
  static const EdgeInsets screenH = EdgeInsets.symmetric(horizontal: 16);
  static const double headerTopPad = 48;
}

// ─── Border Radius ────────────────────────────────────────────────────────────

class SPRadius {
  SPRadius._();

  static const double field   = 6;
  static const double badge   = 8;
  static const double action  = 12;
  static const double card    = 16;
  static const double pill    = 100;

  static const BorderRadius fieldRadius  = BorderRadius.all(Radius.circular(field));
  static const BorderRadius badgeRadius  = BorderRadius.all(Radius.circular(badge));
  static const BorderRadius actionRadius = BorderRadius.all(Radius.circular(action));
  static const BorderRadius cardRadius   = BorderRadius.all(Radius.circular(card));
  static const BorderRadius pillRadius   = BorderRadius.all(Radius.circular(pill));
}

// ─── Sombras ──────────────────────────────────────────────────────────────────

class SPShadows {
  SPShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x12000000), blurRadius: 3, offset: Offset(0, 1)),
    BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
  ];
}

// ─── Chips de estado ──────────────────────────────────────────────────────────

enum SPStatus { saludable, advertencia, critico, activo, alerta, sinsenal }

class SPStatusTokens {
  static const Map<SPStatus, ({Color bg, Color text, String label})> map = {
    SPStatus.saludable:   (bg: Color(0xFFDCFCE7), text: Color(0xFF166534), label: 'Saludable'),
    SPStatus.advertencia: (bg: Color(0xFFFEF9C3), text: Color(0xFF713F12), label: 'Advertencia'),
    SPStatus.critico:     (bg: Color(0xFFFEE2E2), text: Color(0xFF991B1B), label: 'Crítico'),
    SPStatus.activo:      (bg: Color(0xFFDCFCE7), text: Color(0xFF166534), label: 'Activo'),
    SPStatus.alerta:      (bg: Color(0xFFFEF9C3), text: Color(0xFF713F12), label: 'Alerta'),
    SPStatus.sinsenal:    (bg: Color(0xFFF3F4F6), text: Color(0xFF6B7280), label: 'Sin señal'),
  };

  static SPStatus fromString(String s) => switch (s.toLowerCase()) {
    'saludable'   => SPStatus.saludable,
    'advertencia' => SPStatus.advertencia,
    'critico'     => SPStatus.critico,
    'activo'      => SPStatus.activo,
    'alerta'      => SPStatus.alerta,
    _             => SPStatus.sinsenal,
  };
}

// ─── Niveles de alerta ────────────────────────────────────────────────────────

enum AlertLevel { critico, advertencia, info, ok }

class SPAlertTokens {
  static const Map<AlertLevel, Color> color = {
    AlertLevel.critico:     Color(0xFFEF4444),
    AlertLevel.advertencia: Color(0xFFEAB308),
    AlertLevel.info:        Color(0xFF3B82F6),
    AlertLevel.ok:          Color(0xFF22C55E),
  };

  static const Map<AlertLevel, String> label = {
    AlertLevel.critico:     'CRÍTICO',
    AlertLevel.advertencia: 'ADVERTENCIA',
    AlertLevel.info:        'INFO',
    AlertLevel.ok:          'OK',
  };

  // Acepta tanto 'crit'/'warn' (entity) como 'CRITICO'/'ADVERTENCIA' (display)
  static AlertLevel fromString(String s) {
    final upper = s.toUpperCase();
    if (upper == 'CRITICO' || upper == 'CRIT' || upper == 'CRITICAL') {
      return AlertLevel.critico;
    }
    if (upper == 'ADVERTENCIA' || upper == 'WARN' || upper == 'WARNING') {
      return AlertLevel.advertencia;
    }
    if (upper == 'INFO') return AlertLevel.info;
    return AlertLevel.ok;
  }
}

// ─── Color de batería ─────────────────────────────────────────────────────────

Color batteryColor(int pct) {
  if (pct < 20) return SPColors.crit;
  if (pct < 50) return SPColors.warn;
  return SPColors.primary;
}

// ─── Color de progreso de parcela ─────────────────────────────────────────────

Color plotHealthColor(SPStatus status) => switch (status) {
  SPStatus.saludable   => SPColors.primary,
  SPStatus.advertencia => SPColors.warn,
  SPStatus.critico     => SPColors.crit,
  _                    => SPColors.muted,
};

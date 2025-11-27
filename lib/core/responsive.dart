import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints estándar
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;
  static const double _largeDesktopBreakpoint = 1800;

  // Método para obtener el ancho y alto de la pantalla
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // Método para obtener la orientación
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  // Método para obtener el padding seguro
  static EdgeInsets getSafeArea(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  // Método para obtener el ancho disponible (sin safe area)
  static double getAvailableWidth(BuildContext context) {
    final size = getScreenSize(context);
    final safeArea = getSafeArea(context);
    return size.width - safeArea.left - safeArea.right;
  }

  // Método para obtener el alto disponible (sin safe area)
  static double getAvailableHeight(BuildContext context) {
    final size = getScreenSize(context);
    final safeArea = getSafeArea(context);
    return size.height - safeArea.top - safeArea.bottom;
  }

  // Detección de plataforma por tamaño
  static bool isMobile(BuildContext context) {
    return getAvailableWidth(context) < _mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = getAvailableWidth(context);
    return width >= _mobileBreakpoint && width < _tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    final width = getAvailableWidth(context);
    return width >= _tabletBreakpoint && width < _desktopBreakpoint;
  }

  static bool isLargeDesktop(BuildContext context) {
    return getAvailableWidth(context) >= _desktopBreakpoint;
  }

  // Detección de orientación
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  // Método para obtener el tipo de dispositivo como String
  static String getDeviceType(BuildContext context) {
    if (isMobile(context)) return 'mobile';
    if (isTablet(context)) return 'tablet';
    if (isDesktop(context)) return 'desktop';
    return 'large_desktop';
  }

  // Métodos para dimensiones responsivas
  static double responsiveValue({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile * 1.2;
    if (isDesktop(context)) return desktop ?? mobile * 1.5;
    return largeDesktop ?? desktop ?? mobile * 2.0;
  }

  // Método para padding/margin responsivo
  static EdgeInsets responsivePadding({
    required BuildContext context,
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? largeDesktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    return largeDesktop ?? desktop ?? tablet ?? mobile;
  }

  // Método para borderRadius responsivo
  static BorderRadius responsiveBorderRadius({
    required BuildContext context,
    required BorderRadius mobile,
    BorderRadius? tablet,
    BorderRadius? desktop,
    BorderRadius? largeDesktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    return largeDesktop ?? desktop ?? tablet ?? mobile;
  }

  // Método para tamaño de texto responsivo
  static double responsiveTextSize({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile * 1.1;
    if (isDesktop(context)) return desktop ?? mobile * 1.25;
    return largeDesktop ?? desktop ?? mobile * 1.5;
  }

  // Método para grid responsivo
  static int responsiveGridCount({
    required BuildContext context,
    required int mobile,
    int? tablet,
    int? desktop,
    int? largeDesktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? (isPortrait(context) ? 2 : 3);
    if (isDesktop(context)) return desktop ?? 3;
    return largeDesktop ?? 4;
  }

  // Método para ancho de imagen responsivo
  static double responsiveImageWidth({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    final availableWidth = getAvailableWidth(context);

    if (isMobile(context)) {
      return mobile > availableWidth ? availableWidth : mobile;
    }
    if (isTablet(context)) {
      final tabletWidth = tablet ?? mobile * 1.5;
      return tabletWidth > availableWidth ? availableWidth : tabletWidth;
    }
    if (isDesktop(context)) {
      final desktopWidth = desktop ?? mobile * 2.0;
      return desktopWidth > availableWidth ? availableWidth * 0.8 : desktopWidth;
    }
    final largeWidth = largeDesktop ?? desktop ?? mobile * 2.5;
    return largeWidth > availableWidth ? availableWidth * 0.6 : largeWidth;
  }

  // Método para layout condicional
  static T responsiveLayout<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    return largeDesktop ?? desktop ?? tablet ?? mobile;
  }

  // Método para debug - verificar los breakpoints
  static void debugBreakpoints(BuildContext context) {
    final width = getAvailableWidth(context);
    print('''
📱 Responsive Debug:
   • Screen Width: $width
   • Mobile (<$_mobileBreakpoint): ${isMobile(context)}
   • Tablet (>=$_mobileBreakpoint && <$_tabletBreakpoint): ${isTablet(context)}
   • Desktop (>=$_tabletBreakpoint && <$_desktopBreakpoint): ${isDesktop(context)}
   • Large Desktop (>=$_desktopBreakpoint): ${isLargeDesktop(context)}
   • Orientation: ${getOrientation(context)}
   • Device Type: ${getDeviceType(context)}
''');
  }
}
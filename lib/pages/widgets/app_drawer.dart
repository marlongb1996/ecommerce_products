import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import 'empty_page.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onSignOut;

  const AppDrawer({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colorScheme.primary),
            child: Text(
              "Menú",
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: Responsive.responsiveTextSize(
                  context: context,
                  mobile: 24,
                  tablet: 28,
                  desktop: 32,
                  largeDesktop: 36,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: colorScheme.onSurface),
            title: Text(
              "Perfil",
              style: TextStyle(
                fontSize: Responsive.responsiveTextSize(
                  context: context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                  largeDesktop: 22,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EmptyPage(title: "Perfil"),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt, color: colorScheme.onSurface),
            title: Text(
              "Mis productos",
              style: TextStyle(
                fontSize: Responsive.responsiveTextSize(
                  context: context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                  largeDesktop: 22,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EmptyPage(title: "Mis productos"),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: colorScheme.onSurface),
            title: Text(
              "Configuraciones",
              style: TextStyle(
                fontSize: Responsive.responsiveTextSize(
                  context: context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                  largeDesktop: 22,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EmptyPage(title: "Configuraciones"),
                ),
              );
            },
          ),
          Divider(color: colorScheme.onSurface.withOpacity(0.2)),
          ListTile(
            leading: Icon(Icons.logout, color: colorScheme.error),
            title: Text(
              "Cerrar sesión",
              style: TextStyle(
                fontSize: Responsive.responsiveTextSize(
                  context: context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                  largeDesktop: 22,
                ),
                color: colorScheme.error,
              ),
            ),
            onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}

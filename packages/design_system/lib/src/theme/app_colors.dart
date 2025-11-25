import 'package:flutter/material.dart';

class AppColors {
  // --- Brand & Identity ---
  static const primary = Color(0xFF11C76F); // Verde característico
  static const secondary = Color(0xFF008F39);

  // --- Backgrounds ---
  static const background = Color(0xFFFFFFFF); // Fundo padrão de telas
  static const backgroundChat = Color(0xFFEFE7DE); // Fundo estilo WhatsApp (Bege)

  // --- Surfaces (Neutrals) ---
  static const surfacePrimary = Color(0xFFFFFFFF);
  static const surfaceSecondary = Color(0xFFF5F5F5); // Cinza bem claro (Cards/Headers)
  static const surfaceNeutral = Color(0xFFEEEEEE);   // Cinza para inputs/search bars

  // --- Typography & Icons ---
  static const textPrimary = Color(0xFF1D2226); // Quase preto (Melhor leitura que 000)
  static const textSecondary = Color(0xFF6D757D); // Cinza médio para legendas
  static const iconPrimary = Color(0xFF1D2226);
  static const iconSecondary = Color(0xFF757575);

  // --- Chat Specifics ---
  static const bubbleMe = Color(0xFFE7FFDB); // Verde claro (Msg enviada)
  static const bubbleOther = Color(0xFFFFFFFF); // Branco (Msg recebida)
  static const badgeColor = Color(0xFF11C76F); // Bolinha de contador
  static const separator = Color(0xFFE0E0E0); // Divisores de lista
}
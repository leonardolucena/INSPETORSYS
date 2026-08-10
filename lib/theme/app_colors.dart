import 'package:flutter/material.dart';

abstract final class AppColors {
  // Dark
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color backgroundCardDark = Color(0xFF2C2C2C);
  static const Color borderCardDark = Color(0xFF3F3F3F);
  static const Color primaryTextColorDark = Color(0xFFF5F5F5);
  static const Color secondTextColorDark = Color(0xFFEAAE0E);
  static const Color thirdTextColorDark = Color(0xFFEFEFEF);
  static const Color fourthTextColorDark = Color(0xFF2C2C2C);

  // Light
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundCardLight = Color(0xFFFFFFFF);
  static const Color listScreenBackgroundLight = Color(0xFFF0F2F9);
  static const Color listScreenCardLight = Color(0xFFFFFFFF);
  static const Color listScreenBorderLight = Color(0xFFD8DCEB);
  static const Color primaryTextColorLight = Color(0xFF474646);
  static const Color secondTextColorLight = Color(0xFFEAAE0E);
  static const Color thirdTextColorLight = Color(0xFF2C2C2C);
  static const Color fourthTextColorLight = Color(0xFFF5F5F5);

  // Error
  static const Color backgroundError = Color(0xFF250606);
  static const Color borderError = Color(0xFFB13A3A);

  // Status — Draft (neutral)
  static const Color statusDraft = Color(0xFF6C757D);
  static const Color statusDraftBg = Color(0xFFE9ECEF);
  static const Color statusDraftBorder = Color(0xFFDEE2E6);
  static const Color statusDraftDark = Color(0xFFB0B0B0);
  static const Color statusDraftBgDark = Color(0xFF3A3A3A);
  static const Color statusDraftBorderDark = Color(0xFF4A4A4A);

  // Status — Pending (warning)
  static const Color statusPending = Color(0xFFE65100);
  static const Color statusPendingBg = Color(0xFFFFF3CD);
  static const Color statusPendingBorder = Color(0xFFFFECB5);
  static const Color statusPendingDark = Color(0xFFFFB74D);
  static const Color statusPendingBgDark = Color(0xFF4A3A1A);
  static const Color statusPendingBorderDark = Color(0xFF6B4F1D);

  // Status — Success / Enviado
  static const Color statusSuccess = Color(0xFF198754);
  static const Color statusSuccessBg = Color(0xFFD1E7DD);
  static const Color statusSuccessBorder = Color(0xFFBADBCC);
  static const Color statusSuccessDark = Color(0xFF81C784);
  static const Color statusSuccessBgDark = Color(0xFF1B3A2A);
  static const Color statusSuccessBorderDark = Color(0xFF2E5E40);

  // Status — Danger / Falhou (Bootstrap soft)
  static const Color statusDanger = Color(0xFF842029);
  static const Color statusDangerBg = Color(0xFFF8D7DA);
  static const Color statusDangerBorder = Color(0xFFF1AEB5);
  static const Color statusDangerDark = Color(0xFFF48FB1);
  static const Color statusDangerBgDark = Color(0xFF3D1F24);
  static const Color statusDangerBorderDark = Color(0xFF5C2B33);

  // Work order badges — paleta harmônica (accent único por variante)
  //
  // Status (ciclo de vida): cinza → azul → verde — Carbon Design System
  // Prioridade (urgência): vermelho → âmbar → pedra — escala quente, alinhada ao brand #EAAE0E
  // Fundo/borda derivados no widget (padrão shadcn/Radix: alpha consistente)

  static const Color workOrderStatusOpenAccent = Color(0xFF6B7280);
  static const Color workOrderStatusOpenAccentDark = Color(0xFF9CA3AF);
  static const Color workOrderStatusInProgressAccent = Color(0xFF2563EB);
  static const Color workOrderStatusInProgressAccentDark = Color(0xFF60A5FA);
  static const Color workOrderStatusDoneAccent = Color(0xFF059669);
  static const Color workOrderStatusDoneAccentDark = Color(0xFF34D399);

  static const Color workOrderPriorityHighAccent = Color(0xFFDC2626);
  static const Color workOrderPriorityHighAccentDark = Color(0xFFF87171);
  static const Color workOrderPriorityMediumAccent = Color(0xFFB45309);
  static const Color workOrderPriorityMediumAccentDark = Color(0xFFFBBF24);
  static const Color workOrderPriorityLowAccent = Color(0xFF0891B2);
  static const Color workOrderPriorityLowAccentDark = Color(0xFF90D5FF);

  // Segmented control
  static const Color segmentControlTrackLight = Color(0xFFE4E8F4);
  static const Color segmentControlBorderLight = Color(0xFFD5DAE8);
  static const Color segmentControlThumbLight = Color(0xFFFFFFFF);
  static const Color segmentControlTrackDark = Color(0xFF3A3F44);
  static const Color segmentControlBorderDark = Color(0xFF4A4F5C);
  static const Color segmentControlThumbDark = Color(0xFF4A4F55);
}

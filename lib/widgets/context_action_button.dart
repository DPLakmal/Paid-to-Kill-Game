import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/bridge_messages.dart';

/// Ultra-HD Contextual Action Button (Closet Concealment / Exit / Interact).
class ContextActionButton extends StatelessWidget {
  final ContextActionType actionType;
  final VoidCallback onPressed;

  const ContextActionButton({
    super.key,
    required this.actionType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (actionType == ContextActionType.none) {
      return const SizedBox.shrink();
    }

    String labelText;
    IconData iconData;
    Color buttonColor;

    switch (actionType) {
      case ContextActionType.hide:
        labelText = 'CONCEAL IN CLOSET';
        iconData = Icons.meeting_room;
        buttonColor = const Color(0xFFFF9800);
        break;
      case ContextActionType.exitCabinet:
        labelText = 'EXIT CLOSET';
        iconData = Icons.door_front_door_outlined;
        buttonColor = const Color(0xFFFF9800);
        break;
      case ContextActionType.interact:
        labelText = 'RETRIEVE DATA KEY';
        iconData = Icons.vpn_key;
        buttonColor = const Color(0xFFFFC107);
        break;
      case ContextActionType.takedown:
        labelText = 'SILENT TAKEDOWN';
        iconData = Icons.flash_on;
        buttonColor = const Color(0xFFD32F2F);
        break;
      case ContextActionType.plantCharge:
        labelText = 'PLANT C4 CHARGE';
        iconData = Icons.timer;
        buttonColor = const Color(0xFFE53935);
        break;
      case ContextActionType.none:
        return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor.withValues(alpha: 0.9),
            foregroundColor: Colors.black,
            elevation: 12,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          icon: Icon(iconData, size: 28),
          label: Text(
            labelText,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              fontFamily: 'monospace',
              letterSpacing: 1.0,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

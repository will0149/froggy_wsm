import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../domain/usecases/saved_events_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

/// Corazón del detalle: guarda o quita el evento de Guardados. Mientras
/// carga la lista usa el `is_saved` del evento.
class SaveEventButton extends ConsumerWidget {
  final EventDTO event;

  const SaveEventButton({super.key, required this.event});

  Future<void> _toggle(BuildContext context, WidgetRef ref) async {
    HapticFeedback.selectionClick();
    final messenger = ScaffoldMessenger.of(context);
    final error =
        await ref.read(savedEventsUCProvider.notifier).toggle(event);
    if (error != null) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final saved = ref
            .watch(savedEventsUCProvider)
            .value
            ?.any((saved) => saved.id == event.id) ??
        event.isSaved ??
        false;

    // Favorito: emoción, va en naranja de marca.
    return IconButton.outlined(
      tooltip: saved ? s.unsaveEvent : s.saveEvent,
      isSelected: saved,
      style: IconButton.styleFrom(
        minimumSize: const Size.square(48),
        side: BorderSide(color: colors(context).outline),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(ParkeaRadius.md)),
        ),
      ),
      icon: Icon(Icons.favorite_border, color: colors(context).onSurfaceMuted),
      selectedIcon: Icon(Icons.favorite, color: colors(context).brand),
      onPressed: () => _toggle(context, ref),
    );
  }
}

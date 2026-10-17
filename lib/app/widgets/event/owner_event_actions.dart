import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../domain/usecases/owner_events_uc.dart';
import '../../../generated/l10n.dart';
import '../../pages/event/create_event_page.dart';
import '../../themes/colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Acciones del organizador en el detalle de su evento: editar, borrar y ver
/// el código de acceso de un evento PRIVATE.
class EditEventButton extends StatelessWidget {
  final EventDTO event;

  const EditEventButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.pushNamed(EditEventPage.routeName,
          pathParameters: {'id': event.id!}),
      icon: const Icon(Icons.edit),
      label: Text(S.of(context).editEvent),
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
    );
  }
}

/// Botón del AppBar que borra el evento tras confirmarlo y cierra el
/// detalle.
class DeleteEventButton extends ConsumerStatefulWidget {
  final EventDTO event;

  const DeleteEventButton({super.key, required this.event});

  @override
  ConsumerState<DeleteEventButton> createState() => _DeleteEventButtonState();
}

class _DeleteEventButtonState extends ConsumerState<DeleteEventButton> {
  bool _deleting = false;

  Future<void> _delete() async {
    final s = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.deleteEvent),
        content: Text(s.deleteEventConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(s.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error),
            onPressed: () => Navigator.pop(context, true),
            child: Text(s.deleteEvent),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _deleting = true);
    final error = await ref
        .read(ownerEventsUCProvider.notifier)
        .delete(int.parse(widget.event.id!));
    if (!mounted) return;
    setState(() => _deleting = false);
    final messenger = ScaffoldMessenger.of(context);
    if (error == null) context.pop();
    messenger.showSnackBar(SnackBar(content: Text(error ?? s.eventDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: ParkeaOverlay.scrim,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        tooltip: S.of(context).deleteEvent,
        onPressed: _deleting ? null : _delete,
        icon: _deleting
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: ParkeaOverlay.onImage),
              )
            : const Icon(Icons.delete_outline, color: ParkeaOverlay.onImage),
      ),
    );
  }
}

/// Código de acceso de un evento PRIVATE para que el organizador lo
/// comparta. `event/details/` no lo incluye; viene de `events/owner/`.
class AccessCodeCard extends ConsumerWidget {
  final EventDTO event;

  const AccessCodeCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otp = ref
        .watch(ownerEventsUCProvider)
        .value
        ?.where((owned) => owned.id == event.id)
        .firstOrNull
        ?.otp;
    if (otp == null || otp.isEmpty) return const SizedBox.shrink();
    final s = S.of(context);
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
        child: Row(
          children: [
            Icon(Icons.lock_outline, color: colors(context).primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(s.accessCode, style: theme.textTheme.titleSmall),
                  SelectableText(
                    otp,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(s.accessCodeOwnerHint, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: otp));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(s.codeCopied)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

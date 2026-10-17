import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../data/dtos/ticket_dto.dart';
import '../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../../domain/usecases/fetch_events_uc.dart';
import '../../../domain/usecases/fetch_tickets_uc.dart';
import '../../../generated/l10n.dart';
import '../../pages/ticket/tickets_page.dart';
import '../../themes/colors/app_colors.dart';
import '../../utils/event_format.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Botón principal del detalle de evento: inscribirse (`ticket/enroll/`), ver
/// el ticket si ya está inscrito o, deshabilitado, el motivo por el que no
/// puede inscribirse.
class EnrollButton extends ConsumerStatefulWidget {
  final EventDTO event;

  const EnrollButton({super.key, required this.event});

  @override
  ConsumerState<EnrollButton> createState() => _EnrollButtonState();
}

class _EnrollButtonState extends ConsumerState<EnrollButton> {
  bool _enrolling = false;

  int get _eventId => int.parse(widget.event.id!);

  Future<EnrollResult> _enroll({String? otp}) =>
      ref.read(myTicketsUCProvider.notifier).enroll(_eventId, otp: otp);

  Future<void> _onEnroll() async {
    final EnrollResult? result;
    if (widget.event.eventType == 'PRIVATE') {
      // El diálogo muestra los errores del código y solo se cierra con
      // otro resultado.
      result = await showDialog<EnrollResult>(
        context: context,
        builder: (_) => _AccessCodeDialog(onSubmit: (otp) => _enroll(otp: otp)),
      );
    } else {
      setState(() => _enrolling = true);
      result = await _enroll();
      if (mounted) setState(() => _enrolling = false);
    }
    if (result == null || !mounted) return;
    final s = S.of(context);
    if (result is Enrolled) {
      // Actualiza los cupos disponibles.
      ref.invalidate(fetchEventDetailUCProvider(_eventId));
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(switch (result) {
        Enrolled() => s.enrolledSuccess,
        EnrollFailed(:final message) => message,
      }),
    ));
  }

  /// Motivo por el que no puede inscribirse, null si puede.
  String? _blockedReason(S s, String? username) {
    final event = widget.event;
    final date = DateTime.tryParse(event.date ?? '');
    if (date != null && date.isBefore(DateTime.now())) return s.eventFinished;
    if (event.isOwnedBy(username)) return s.ownEvent;
    if (event.eventType == 'INVITATION') return s.invitationOnly;
    if (event.availableSpots == 0) return s.soldOut;
    if (event.eventType == 'PAID') return s.paymentsComingSoon;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final event = widget.event;
    final tickets = ref.watch(myTicketsUCProvider);
    final username = ref.watch(restAuthUCProvider).value?.user?.username;
    final TicketDTO? ticket = tickets.value
        ?.where((ticket) => ticket.event.id == event.id)
        .firstOrNull;
    final price = event.eventType == 'PAID'
        ? event.formattedPrice(Localizations.localeOf(context).toString())
        : null;

    final String label;
    VoidCallback? onPressed;
    if (ticket != null) {
      label = s.viewMyTicket;
      onPressed =
          () => TicketDetailSheet.show(context, ticket, showEventButton: false);
    } else if (_blockedReason(s, username) case final reason?) {
      label = price == null ? reason : '$reason · $price';
    } else {
      label =
          event.eventType == 'FREE' ? '${s.enroll} · ${s.costFree}' : s.enroll;
      // Sin la lista de tickets no se sabe si ya está inscrito.
      if (!tickets.isLoading && !_enrolling) onPressed = _onEnroll;
    }

    final loading = _enrolling || (tickets.isLoading && !tickets.hasValue);
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
      child: loading
          ? SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: colors(context).onPrimary),
            )
          : Text(label, textAlign: TextAlign.center),
    );
  }
}

/// Pide el código de un evento PRIVATE. Un código inválido se muestra en el
/// campo; cualquier otro resultado cierra el diálogo y se devuelve.
class _AccessCodeDialog extends StatefulWidget {
  final Future<EnrollResult> Function(String otp) onSubmit;

  const _AccessCodeDialog({required this.onSubmit});

  @override
  State<_AccessCodeDialog> createState() => _AccessCodeDialogState();
}

class _AccessCodeDialogState extends State<_AccessCodeDialog> {
  final _controller = TextEditingController();
  bool _sending = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final s = S.of(context);
    final otp = _controller.text.trim();
    if (otp.isEmpty) {
      setState(() => _error = s.accessCodeRequired);
      return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });
    final result = await widget.onSubmit(otp);
    if (!mounted) return;
    if (result case EnrollFailed(field: 'otp')) {
      setState(() {
        _sending = false;
        _error = s.invalidAccessCode;
      });
      // Seleccionado para reescribirlo directamente.
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      return;
    }
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AlertDialog(
      title: Text(s.accessCode),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(s.accessCodeHint),
          TextField(
            controller: _controller,
            autofocus: true,
            // readOnly y no enabled: deshabilitarlo le quita el foco.
            readOnly: _sending,
            // El código distingue mayúsculas.
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
            onSubmitted: (_) => _submit(),
            // Por defecto quita el foco; se mantiene para corregir el código.
            onEditingComplete: () {},
            decoration: InputDecoration(
              labelText: s.accessCode,
              errorText: _error,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _sending ? null : () => Navigator.pop(context),
          child: Text(s.cancel),
        ),
        FilledButton(
          onPressed: _sending ? null : _submit,
          child: _sending
              ? SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: colors(context).onPrimary),
                )
              : Text(s.enroll),
        ),
      ],
    );
  }
}

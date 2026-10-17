import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:parkea/app/themes/colors/app_colors.dart';
import 'package:parkea/app/themes/dimens.dart';
import 'package:parkea/data/dtos/ticket_dto.dart';
import 'package:parkea/domain/usecases/fetch_events_uc.dart';
import 'package:parkea/domain/usecases/fetch_tickets_uc.dart';

import '../../../generated/l10n.dart';
import '../event/event_detail_page.dart';

class TicketsPage extends ConsumerStatefulWidget {
  static String get routeName => 'tickets';
  static String get routeLocation => '/$routeName';

  const TicketsPage({super.key});

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends ConsumerState<TicketsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final tickets = ref.watch(myTicketsUCProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            title: Text(s.myTickets),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: s.ticketsUpcoming),
                Tab(text: s.ticketsPast),
              ],
            ),
          ),
        ],
        body: switch (tickets) {
          AsyncValue(:final value?) => TabBarView(
              controller: _tabController,
              children: [
                _TicketList(
                  // Los más cercanos primero.
                  tickets: value.where((t) => t.isUpcoming).toList(),
                  emptyMessage: s.noUpcomingTickets,
                ),
                _TicketList(
                  // Los más recientes primero.
                  tickets: value
                      .where((t) => !t.isUpcoming)
                      .toList()
                      .reversed
                      .toList(),
                  emptyMessage: s.noPastTickets,
                ),
              ],
            ),
          AsyncError() => _Message(
              icon: Icons.cloud_off,
              text: s.ticketsLoadError,
              onRetry: () => ref.invalidate(myTicketsUCProvider),
            ),
          _ => const Center(child: CircularProgressIndicator.adaptive()),
        },
      ),
    );
  }
}

class _TicketList extends ConsumerWidget {
  final List<TicketDTO> tickets;
  final String emptyMessage;

  const _TicketList({required this.tickets, required this.emptyMessage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).toString();
    // La barra inferior se dibuja sobre el body (extendBody).
    final bottom = MediaQuery.paddingOf(context).bottom + 16;
    final rows = <Widget>[];
    String? month;
    for (final ticket in tickets) {
      final date = ticket.eventDate;
      final label = date == null ? '' : DateFormat.yMMMM(locale).format(date);
      if (label != month) {
        month = label;
        rows.add(_MonthHeader(label: label));
      }
      rows.add(_TicketCard(ticket: ticket));
    }

    return RefreshIndicator(
      onRefresh: () => ref.refresh(myTicketsUCProvider.future),
      child: tickets.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                _Message(icon: Icons.confirmation_number, text: emptyMessage),
              ],
            )
          : ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 8, 16, bottom),
              children: rows,
            ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final String label;

  const _MonthHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 4,
            height: 20,
            // Acento de marca: forma, sin texto.
            decoration: BoxDecoration(
              color: colors(context).brand,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final TicketDTO ticket;

  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final locale = Localizations.localeOf(context).toString();
    final event = ticket.event;
    final date = ticket.eventDate;
    return Card(
      margin: const EdgeInsets.only(bottom: ParkeaSpacing.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => TicketDetailSheet.show(context, ticket),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 104,
              child: _EventImage(
                url: event.bannerImageUrl,
                grayscale: !ticket.isUpcoming,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      event.eventName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    if (date != null)
                      _IconText(
                        icon: Icons.calendar_today,
                        color: theme.colorScheme.primary,
                        text: DateFormat('EEE d MMM · HH:mm', locale)
                            .format(date),
                      ),
                    if (event.location?.place case final place?
                        when place.isNotEmpty)
                      _IconText(
                        icon: Icons.place,
                        color: theme.colorScheme.onSurfaceVariant,
                        text: place,
                      ),
                    Text(
                      s.ticketNumber(ticket.id),
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _IconText(
      {required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(icon, size: 14, color: color),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _EventImage extends StatelessWidget {
  final String? url;
  final bool grayscale;

  const _EventImage({required this.url, this.grayscale = false});

  @override
  Widget build(BuildContext context) {
    const placeholder = DecoratedBox(
      decoration: BoxDecoration(gradient: ParkeaOverlay.brandGradient),
      child: Center(
          child: Icon(Icons.celebration, color: ParkeaOverlay.onImage)),
    );
    final image = url == null || url!.isEmpty
        ? placeholder
        : CachedNetworkImage(
            imageUrl: url!,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => placeholder,
          );
    if (!grayscale) return image;
    // Los tickets de eventos pasados se ven apagados.
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.2126, 0.7152, 0.0722, 0, 0, //
        0.2126, 0.7152, 0.0722, 0, 0, //
        0.2126, 0.7152, 0.0722, 0, 0, //
        0, 0, 0, 1, 0, //
      ]),
      child: image,
    );
  }
}

class TicketDetailSheet extends ConsumerStatefulWidget {
  final TicketDTO ticket;

  /// Falso cuando se abre desde el detalle del mismo evento.
  final bool showEventButton;

  const TicketDetailSheet(
      {super.key, required this.ticket, this.showEventButton = true});

  static Future<void> show(BuildContext context, TicketDTO ticket,
          {bool showEventButton = true}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        // Por encima de la barra inferior.
        useRootNavigator: true,
        builder: (_) =>
            TicketDetailSheet(ticket: ticket, showEventButton: showEventButton),
      );

  @override
  ConsumerState<TicketDetailSheet> createState() => _TicketDetailSheetState();
}

class _TicketDetailSheetState extends ConsumerState<TicketDetailSheet> {
  bool _cancelling = false;

  Future<void> _cancel() async {
    final s = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(s.cancelTicketConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(s.keepTicket),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(s.cancelTicket),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _cancelling = true);
    final error =
        await ref.read(myTicketsUCProvider.notifier).cancel(widget.ticket.id);
    if (!mounted) return;
    setState(() => _cancelling = false);
    // Libera un cupo en el detalle del evento.
    final eventId = int.tryParse(widget.ticket.event.id ?? '');
    if (error == null && eventId != null) {
      ref.invalidate(fetchEventDetailUCProvider(eventId));
    }
    final messenger = ScaffoldMessenger.of(context);
    if (error == null) Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(error ?? s.ticketCancelled)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final locale = Localizations.localeOf(context).toString();
    final ticket = widget.ticket;
    final event = ticket.event;
    final date = ticket.eventDate;
    final purchased = DateTime.tryParse(ticket.datePurchased ?? '')?.toLocal();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 2,
                child: _EventImage(
                  url: event.bannerImageUrl,
                  grayscale: !ticket.isUpcoming,
                ),
              ),
            ),
            Text(
              event.eventName ?? '',
              style: theme.textTheme.titleLarge,
            ),
            if (date != null)
              _IconText(
                icon: Icons.calendar_today,
                color: theme.colorScheme.primary,
                text: DateFormat('EEEE d MMMM y · HH:mm', locale).format(date),
              ),
            if (event.location?.place case final place? when place.isNotEmpty)
              _IconText(
                  icon: Icons.place,
                  color: theme.colorScheme.onSurfaceVariant,
                  text: place),
            Text(s.ticketNumber(ticket.id), style: theme.textTheme.labelLarge),
            if (purchased != null)
              Text(
                s.enrolledOn(DateFormat.yMMMd(locale).format(purchased)),
                style: theme.textTheme.bodySmall,
              ),
            const SizedBox(height: 4),
            if (widget.showEventButton)
              FilledButton(
                onPressed: event.id == null
                    ? null
                    : () {
                        Navigator.pop(context);
                        context.pushNamed(EventDetailPage.routeName,
                            pathParameters: {'id': event.id!});
                      },
                child: Text(s.viewEvent),
              ),
            if (ticket.isUpcoming)
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error),
                onPressed: _cancelling ? null : _cancel,
                child: _cancelling
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(s.cancelTicket),
              ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onRetry;

  const _Message({required this.icon, required this.text, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Icon(icon, size: 48, color: colors(context).onSurfaceMuted),
          Text(text, textAlign: TextAlign.center),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: Text(S.of(context).retry)),
        ],
      ),
    );
  }
}

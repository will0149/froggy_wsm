import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/data/dtos/user_ticket_dto.dart';
import 'package:parkea/domain/providers/app_theme_provider.dart';
import 'package:parkea/domain/usecases/fetch_tickets_uc.dart';

class TicketsPage extends ConsumerStatefulWidget {
  static String get routeName => 'tickets';
  static String get routeLocation => '/$routeName';

  const TicketsPage({super.key});

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends ConsumerState<TicketsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(appThemeProvider);
    final theme = Theme.of(context);

    final upcoming = ref.watch(fetchUpcomingTicketsUCProvider);
    final past = ref.watch(fetchPastTicketsUCProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor:
                isDarkMode ? parkeaDarkBlueAccent : parkeaOrange,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 56),
              title: Text(
                'Mis Tickets',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDarkMode
                        ? [parkeaDarkBlueAccent, parkeaBlueAccent]
                        : [parkeaOrange, parkeaDarkOrange],
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              labelStyle: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Próximos'),
                Tab(text: 'Anteriores'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _AsyncTicketGrid(state: upcoming, isUpcoming: true),
            _AsyncTicketGrid(state: past, isUpcoming: false),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AsyncValue wrapper
// ---------------------------------------------------------------------------

class _AsyncTicketGrid extends StatelessWidget {
  final AsyncValue<List<UserTicketDTO>> state;
  final bool isUpcoming;

  const _AsyncTicketGrid({required this.state, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return state.when(
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      error: (err, _) => Center(
        child: Text('Error: $err'),
      ),
      data: (tickets) => _TicketGrid(tickets: tickets, isUpcoming: isUpcoming),
    );
  }
}

// ---------------------------------------------------------------------------
// Grid agrupado por mes
// ---------------------------------------------------------------------------

class _TicketGrid extends StatelessWidget {
  final List<UserTicketDTO> tickets;
  final bool isUpcoming;

  const _TicketGrid({required this.tickets, required this.isUpcoming});

  Map<String, List<UserTicketDTO>> get _grouped {
    final grouped = <String, List<UserTicketDTO>>{};
    for (final t in tickets) {
      final date = DateTime.tryParse(t.eventDate ?? '');
      if (date == null) continue;
      final key = DateFormat('MMMM yyyy').format(date);
      grouped.putIfAbsent(key, () => []).add(t);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) return _EmptyState(isUpcoming: isUpcoming);

    final grouped = _grouped;
    final months = grouped.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: months.length,
      itemBuilder: (context, i) {
        final month = months[i];
        final items = grouped[month]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MonthHeader(label: month),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: items.length,
              itemBuilder: (context, j) => _TicketCard(ticket: items[j]),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final String label;

  const _MonthHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: parkeaOrange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: parkeaBlueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tarjeta de ticket
// ---------------------------------------------------------------------------

class _TicketCard extends StatelessWidget {
  final UserTicketDTO ticket;

  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final eventDate = DateTime.tryParse(ticket.eventDate ?? '');
    final isPast = eventDate == null || eventDate.isBefore(DateTime.now());
    final theme = Theme.of(context);
    final quantity = ticket.quantity ?? 1;
    final total = double.tryParse(ticket.totalAmount ?? '0') ?? 0;

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _TicketDetailSheet(ticket: ticket),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Banner ---
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColorFiltered(
                      colorFilter: isPast
                          ? const ColorFilter.matrix([
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0,      0,      0,      1, 0,
                            ])
                          : const ColorFilter.mode(
                              Colors.transparent, BlendMode.color),
                      child: Image.network(
                        ticket.bannerUrl ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: parkeaBlueAccentOpacity,
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.white54),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black54, Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _StatusBadge(status: ticket.status ?? ''),
                    ),
                    if (quantity > 1)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: parkeaOrange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'x$quantity',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // --- Línea perforada ---
              SizedBox(
                height: 20,
                child: CustomPaint(
                  painter: _PerforationPainter(
                      bgColor: theme.scaffoldBackgroundColor),
                  child: const SizedBox.expand(),
                ),
              ),
              // --- Info ---
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.eventName ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      if (eventDate != null)
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 10, color: parkeaOrange),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                DateFormat('d MMM · HH:mm').format(eventDate),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 10, color: parkeaBlueAccent),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              ticket.place ?? '',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[600]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${total.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isPast ? Colors.grey : parkeaOrange,
                            ),
                          ),
                          Icon(
                            Icons.qr_code_2,
                            size: 20,
                            color: isPast
                                ? Colors.grey
                                : parkeaDarkBlueAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'confirmed' => (Colors.green, 'Confirmado'),
      'used' => (Colors.grey, 'Usado'),
      'cancelled' => (Colors.red, 'Cancelado'),
      _ => (Colors.orange, status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _PerforationPainter extends CustomPainter {
  final Color bgColor;

  const _PerforationPainter({required this.bgColor});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.35)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const dashW = 5.0;
    const gap = 4.0;
    double x = 14;
    final y = size.height / 2;

    while (x < size.width - 14) {
      canvas.drawLine(Offset(x, y), Offset(x + dashW, y), linePaint);
      x += dashW + gap;
    }

    final cutPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, y), 10, cutPaint);
    canvas.drawCircle(Offset(size.width, y), 10, cutPaint);
  }

  @override
  bool shouldRepaint(covariant _PerforationPainter old) =>
      old.bgColor != bgColor;
}

class _EmptyState extends StatelessWidget {
  final bool isUpcoming;

  const _EmptyState({required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isUpcoming
                ? Icons.confirmation_num_outlined
                : Icons.history_toggle_off,
            size: 72,
            color: parkeaLightGrey,
          ),
          const SizedBox(height: 16),
          Text(
            isUpcoming
                ? 'No tienes tickets próximos'
                : 'No tienes tickets anteriores',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: parkeaLightGrey,
            ),
          ),
          if (isUpcoming) ...[
            const SizedBox(height: 8),
            const Text(
              'Explora eventos y compra tu primer ticket',
              style: TextStyle(fontSize: 13, color: parkeaLightGrey),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom sheet de detalle
// ---------------------------------------------------------------------------

class _TicketDetailSheet extends StatelessWidget {
  final UserTicketDTO ticket;

  const _TicketDetailSheet({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventDate = DateTime.tryParse(ticket.eventDate ?? '');
    final purchaseDate = DateTime.tryParse(ticket.datePurchased ?? '');
    final total = double.tryParse(ticket.totalAmount ?? '0') ?? 0;

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.94,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: controller,
          padding: EdgeInsets.zero,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 7,
              child: Image.network(
                ticket.bannerUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: parkeaBlueAccentOpacity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          ticket.eventName ?? '',
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _StatusChip(status: ticket.status ?? ''),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (eventDate != null)
                    _DetailRow(
                      icon: Icons.calendar_today,
                      label: 'Fecha del evento',
                      value: DateFormat('EEEE, d MMMM yyyy · HH:mm')
                          .format(eventDate),
                    ),
                  _DetailRow(
                    icon: Icons.location_on,
                    label: 'Lugar',
                    value: ticket.place ?? '',
                  ),
                  _DetailRow(
                    icon: Icons.confirmation_num,
                    label: 'Código de reserva',
                    value: ticket.ticketCode ?? '',
                  ),
                  _DetailRow(
                    icon: Icons.people_outline,
                    label: 'Cantidad',
                    value: '${ticket.quantity ?? 1} ticket(s)',
                  ),
                  _DetailRow(
                    icon: Icons.attach_money,
                    label: 'Total pagado',
                    value:
                        '\$${total.toStringAsFixed(2)} ${ticket.currency ?? ''}',
                  ),
                  if (purchaseDate != null)
                    _DetailRow(
                      icon: Icons.receipt_long,
                      label: 'Fecha de compra',
                      value: DateFormat('d MMMM yyyy, HH:mm')
                          .format(purchaseDate),
                    ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 148,
                      height: 148,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: parkeaBlueAccentOpacity, width: 2),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_2,
                              size: 90, color: parkeaDarkBlueAccent),
                          SizedBox(height: 4),
                          Text(
                            'Código QR',
                            style: TextStyle(
                                fontSize: 12, color: parkeaBlueAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download_outlined),
                      label: const Text('Descargar ticket'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: parkeaOrange,
                        side: const BorderSide(color: parkeaOrange),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: parkeaOrange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 11, color: parkeaLightGrey)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'confirmed' => (Colors.green, 'Confirmado'),
      'used' => (Colors.grey, 'Usado'),
      'cancelled' => (Colors.red, 'Cancelado'),
      _ => (Colors.orange, status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

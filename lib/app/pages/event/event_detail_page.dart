import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/app/widgets/banners/detail_image_banner.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/domain/usecases/fetch_events_uc.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';
import 'package:parkea/domain/usecases/fetch_tickets_uc.dart';
import '../../../domain/providers/icons/svg_icon_provider.dart';
import '../../../generated/l10n.dart';
import '../../widgets/event/enroll_button.dart';
import '../../widgets/event/event_location_card.dart';
import '../../widgets/event/owner_event_actions.dart';
import '../../widgets/event/similar_events.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/30/22

class EventDetailPage extends ConsumerStatefulWidget {
  final int eventId;

  const EventDetailPage({super.key, required this.eventId});

  static String get routeName => 'eventDetail';

  static String get routeLocation => '$routeName/:id';

  @override
  EventDetailPageState createState() => EventDetailPageState();
}

class EventDetailPageState extends ConsumerState<EventDetailPage> {
  Future<void> _refresh() async {
    ref
      ..invalidate(myTicketsUCProvider)
      ..invalidate(fetchEventDetailUCProvider(widget.eventId));
    await ref.read(fetchEventDetailUCProvider(widget.eventId).future);
  }

  @override
  Widget build(BuildContext context) {
    final eventDetail = ref.watch(fetchEventDetailUCProvider(widget.eventId));
    final ownEvent = eventDetail.value;
    final isOwner = ownEvent?.isOwnedBy(_username) ?? false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          if (isOwner) DeleteEventButton(event: ownEvent!),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: eventDetail.when(
          data: (eventDetail) => _buildEventContent(eventDetail, context),
          error: (err, s) => _buildErrorState(err.toString()),
          loading: () => _buildLoadingState(),
        ),
      ),
    );
  }

  String? get _username => ref.watch(restAuthUCProvider).value?.user?.username;

  Widget _buildEventContent(EventDTO event, BuildContext context) {
    final isOwner = event.isOwnedBy(_username);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              DetailImageBanner(event.bannerImageUrl),
              Transform.translate(
                offset: const Offset(0, -20),
                child: _buildEventCard(event, context),
              ),
            ],
          ),
        ),
        if (isOwner && event.eventType == 'PRIVATE')
          SliverToBoxAdapter(child: AccessCodeCard(event: event)),
        if (EventLocationCard.hasLocation(event))
          SliverToBoxAdapter(child: EventLocationCard(event: event)),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildActionButtons(event, context),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        SliverToBoxAdapter(child: SimilarEvents(event: event)),
        const SliverToBoxAdapter(
          child: SizedBox(height: 100), // Bottom padding for FAB
        ),
      ],
    );
  }

  Widget _buildEventCard(EventDTO event, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventName ?? "",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                _buildEventInfo(event, locale, theme),
                const SizedBox(height: 20),
                _buildHostInfo(event, theme),
                const SizedBox(height: 20),
                _buildDescription(event, theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfo(EventDTO event, Locale locale, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: parkeaBlueAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: parkeaBlueAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).eventDateTime,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      switch (DateTime.tryParse(event.date ?? '')) {
                        final date? =>
                          DateFormat('EEEE d MMMM y · HH:mm', locale.toString())
                              .format(date.toLocal()),
                        null => '',
                      },
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: parkeaOrange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).eventLocation,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      event.location?.place ?? "",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHostInfo(EventDTO event, ThemeData theme) {
    return Row(
      children: [
        // El API solo da el username del organizador.
        CircleAvatar(
          radius: 28,
          backgroundColor: parkeaOrange,
          child: Text(
            (event.eventOwner ?? '').isEmpty
                ? '?'
                : event.eventOwner!.characters.first.toUpperCase(),
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).hostedBy,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                event.eventOwner ?? "",
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(EventDTO event, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).aboutEvent,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          event.description ?? "",
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(EventDTO event, BuildContext context) {
    final likeButton = ref.watch(svgIconProvider);

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            icon: Icon(
              likeButton ? Icons.favorite : Icons.favorite_border,
              color: likeButton ? parkeaOrange : Colors.grey[600],
              size: 28,
            ),
            onPressed: () {
              ref.read(svgIconProvider.notifier).setActive(!likeButton);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: event.isOwnedBy(_username)
              ? EditEventButton(event: event)
              : EnrollButton(event: event),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator.adaptive(),
          SizedBox(height: 16),
          Text('Loading event details...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.refresh(fetchEventDetailUCProvider(widget.eventId)),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

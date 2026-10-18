import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parkea/app/widgets/banners/detail_image_banner.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/domain/usecases/fetch_events_uc.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';
import 'package:parkea/domain/usecases/event_attendance_uc.dart';
import 'package:parkea/domain/usecases/fetch_tickets_uc.dart';
import '../../../domain/providers/icons/svg_icon_provider.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/app_colors.dart';
import '../../themes/dimens.dart';
import '../../widgets/event/enroll_button.dart';
import '../../widgets/event/event_location_card.dart';
import '../../widgets/event/owner_event_actions.dart';
import '../../widgets/event/similar_events.dart';
import '../../widgets/gamification/owner_attendance_card.dart';

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
      ..invalidate(eventTicketCountUCProvider(widget.eventId))
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
        // Sobre el banner: botones con velo para que se lean sobre la foto.
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.all(ParkeaSpacing.sm),
          decoration: const BoxDecoration(
            color: ParkeaOverlay.scrim,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: ParkeaOverlay.onImage),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          if (isOwner) DeleteEventButton(event: ownEvent!),
          Container(
            margin: const EdgeInsets.all(ParkeaSpacing.sm),
            decoration: const BoxDecoration(
              color: ParkeaOverlay.scrim,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.share, color: ParkeaOverlay.onImage),
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
              DetailImageBanner(event.galleryUrls),
              Transform.translate(
                offset: const Offset(0, -20),
                child: _buildEventCard(event, context),
              ),
            ],
          ),
        ),
        if (isOwner)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OwnerAttendanceCard(event: event),
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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: ParkeaSpacing.lg),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ParkeaRadius.xl),
        side: BorderSide(color: colors(context).outline),
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
                  style: theme.textTheme.headlineSmall,
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
      padding: const EdgeInsets.all(ParkeaSpacing.lg),
      decoration: BoxDecoration(
        color: colors(context).primaryContainer,
        borderRadius: BorderRadius.circular(ParkeaRadius.md),
      ),
      child: Column(
        children: [
          _infoRow(
            theme,
            icon: Icons.calendar_today,
            label: S.of(context).eventDateTime,
            value: switch (DateTime.tryParse(event.date ?? '')) {
              final date? =>
                DateFormat('EEEE d MMMM y · HH:mm', locale.toString())
                    .format(date.toLocal()),
              null => '',
            },
          ),
          const SizedBox(height: ParkeaSpacing.md),
          _infoRow(
            theme,
            icon: Icons.location_on,
            label: S.of(context).eventLocation,
            value: event.location?.place ?? '',
          ),
        ],
      ),
    );
  }

  Widget _infoRow(ThemeData theme,
      {required IconData icon, required String label, required String value}) {
    final palette = colors(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(ParkeaSpacing.sm),
          decoration: BoxDecoration(
            color: palette.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: palette.onPrimary, size: 20),
        ),
        const SizedBox(width: ParkeaSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: theme.textTheme.labelMedium
                      ?.copyWith(color: palette.onPrimaryContainer)),
              Text(value, style: theme.textTheme.titleSmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHostInfo(EventDTO event, ThemeData theme) {
    return Row(
      children: [
        // El API solo da el username del organizador.
        CircleAvatar(
          radius: 28,
          backgroundColor: colors(context).brandContainer,
          child: Text(
            (event.eventOwner ?? '').isEmpty
                ? '?'
                : event.eventOwner!.characters.first.toUpperCase(),
            style: theme.textTheme.titleLarge
                ?.copyWith(color: colors(context).onBrandContainer),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).hostedBy, style: theme.textTheme.bodySmall),
              Text(event.eventOwner ?? '', style: theme.textTheme.titleMedium),
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
        Text(S.of(context).aboutEvent, style: theme.textTheme.titleMedium),
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
        // Favorito: emoción, va en naranja de marca.
        IconButton.outlined(
          style: IconButton.styleFrom(
            minimumSize: const Size.square(48),
            side: BorderSide(color: colors(context).outline),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(ParkeaRadius.md)),
            ),
          ),
          icon: Icon(
            likeButton ? Icons.favorite : Icons.favorite_border,
            color: likeButton
                ? colors(context).brand
                : colors(context).onSurfaceMuted,
          ),
          onPressed: () {
            ref.read(svgIconProvider.notifier).setActive(!likeButton);
          },
        ),
        const SizedBox(width: ParkeaSpacing.md),
        Expanded(
          child: event.isOwnedBy(_username)
              ? EditEventButton(event: event)
              : EnrollButton(event: event),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 16),
          Text(S.of(context).loadingEvent),
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
            color: colors(context).onSurfaceMuted,
          ),
          const SizedBox(height: ParkeaSpacing.lg),
          Text(
            S.of(context).somethingWentWrong,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: ParkeaSpacing.sm),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.refresh(fetchEventDetailUCProvider(widget.eventId)),
            child: Text(S.of(context).retry),
          ),
        ],
      ),
    );
  }
}

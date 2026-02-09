import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dtos/event_dto.dart';
import '../../domain/providers/onboarding_provider.dart';
import '../../generated/l10n.dart';
import 'cards/event_feed_card.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 03/09/23
class ProfileContentTabBar extends ConsumerStatefulWidget {
  const ProfileContentTabBar({super.key});

  @override
  ProfileContentTabBarState createState() => ProfileContentTabBarState();
}

class ProfileContentTabBarState extends ConsumerState<ProfileContentTabBar> {
  final ScrollController _controller = ScrollController();

  Widget _buildEventsList(AsyncValue<List<EventDTO>> eventsData, String emptyMessage) {
    return eventsData.when(
      data: (events) {
        if (events.isEmpty) {
          return _buildEmptyState(emptyMessage);
        }
        return ListView.builder(
          controller: _controller,
          padding: const EdgeInsets.all(16.0),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: EventFeedCard(
                event: event,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.18,
              ),
            );
          },
        );
      },
      error: (err, s) => _buildErrorState(err.toString()),
      loading: () => _buildLoadingState(),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No Events Found',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
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
                fontWeight: FontWeight.bold,
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
            ElevatedButton.icon(
              onPressed: () => ref.refresh(getEventsProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventsData = ref.watch(getEventsProvider);
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Tab indicator handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  TabBar(
                    indicatorColor: theme.primaryColor,
                    indicatorWeight: 3,
                    labelColor: theme.primaryColor,
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: theme.textTheme.titleSmall,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.event, size: 20),
                            const SizedBox(width: 8),
                            Text(S.of(context).myEvents),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.confirmation_num, size: 20),
                            const SizedBox(width: 8),
                            Text(S.of(context).myEventsPaid),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.bookmark, size: 20),
                            const SizedBox(width: 8),
                            Text(S.of(context).myEventsSaved),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildEventsList(eventsData, 'You haven\'t created any events yet.'),
                  _buildEventsList(eventsData, 'No purchased tickets found.'),
                  _buildEventsList(eventsData, 'No saved events found.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

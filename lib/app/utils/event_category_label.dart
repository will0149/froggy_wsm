import 'package:flutter/material.dart';

import '../../domain/models/event_category.dart';
import '../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/16/26

extension EventCategoryLabel on EventCategory {
  String label(S s) => switch (this) {
        EventCategory.music => s.catMusic,
        EventCategory.camping => s.catCamping,
        EventCategory.adventure => s.catAdventure,
        EventCategory.workshops => s.catWorkshops,
        EventCategory.volunteering => s.catVolunteering,
      };

  IconData get icon => switch (this) {
        EventCategory.music => Icons.music_note_rounded,
        EventCategory.camping => Icons.forest_rounded,
        EventCategory.adventure => Icons.hiking_rounded,
        EventCategory.workshops => Icons.handyman_rounded,
        EventCategory.volunteering => Icons.volunteer_activism_rounded,
      };
}

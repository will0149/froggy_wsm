import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/event_locations_uc.dart';
import '../../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Ubicación elegida para el feed: [country] (ISO alfa-2) y, opcionalmente,
/// [city]. null en el chip = todas las ubicaciones.
typedef FeedLocation = ({String country, String? city});

/// Bandera emoji de un código ISO 3166-1 alfa-2 (`CO` → 🇨🇴).
String countryFlag(String code) => code.length != 2
    ? ''
    : String.fromCharCodes(
        code.toUpperCase().codeUnits.map((unit) => unit + 0x1F1A5));

/// Chip del feed con la ubicación actual; al tocarlo abre el selector.
class LocationFilterChip extends StatelessWidget {
  final FeedLocation? location;
  final ValueChanged<FeedLocation?> onChanged;

  const LocationFilterChip(
      {super.key, required this.location, required this.onChanged});

  Future<void> _pick(BuildContext context) async {
    // El selector devuelve un registro envuelto para distinguir "todas"
    // (null) de cerrar sin elegir.
    final picked = await showModalBottomSheet<({FeedLocation? location})>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      // Por encima de la barra inferior.
      useRootNavigator: true,
      builder: (_) => _LocationSheet(selected: location),
    );
    if (picked != null) onChanged(picked.location);
  }

  @override
  Widget build(BuildContext context) {
    final location = this.location;
    final label = switch (location) {
      null => S.of(context).allLocations,
      (:final country, city: final city?) =>
        '$city, ${countryFlag(country)} $country',
      (:final country, city: null) => '${countryFlag(country)} $country',
    };
    return InputChip(
      avatar: Icon(Icons.place,
          size: 18, color: Theme.of(context).colorScheme.primary),
      label: Text(label, overflow: TextOverflow.ellipsis),
      selected: location != null,
      showCheckmark: false,
      onPressed: () => _pick(context),
      onDeleted: location == null ? null : () => onChanged(null),
    );
  }
}

class _LocationSheet extends ConsumerWidget {
  final FeedLocation? selected;

  const _LocationSheet({required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final locations = ref.watch(eventLocationsUCProvider);

    Widget option(FeedLocation? location, String label, {int? count}) {
      final isSelected = location == selected;
      return ListTile(
        title: Text(label),
        trailing: count == null
            ? null
            : Text('$count', style: theme.textTheme.labelLarge),
        selected: isSelected,
        selectedColor: theme.colorScheme.primary,
        leading: Icon(isSelected ? Icons.check : null),
        onTap: () => Navigator.pop(context, (location: location)),
      );
    }

    return SafeArea(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.7),
        child: switch (locations) {
          AsyncValue(:final value?) => ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(s.filterByLocation,
                      style: theme.textTheme.titleMedium),
                ),
                option(null, s.allLocations),
                for (final MapEntry(key: country, value: cities)
                    in value.entries) ...[
                  const Divider(),
                  option(
                    (country: country, city: null),
                    '${countryFlag(country)}  ${s.allOfCountry(country)}',
                    count: cities.fold<int>(0, (sum, c) => sum + c.count),
                  ),
                  // Los eventos sin ciudad solo entran en "todo el país".
                  for (final city in cities.where((c) => c.city.isNotEmpty))
                    option((country: country, city: city.city), city.city,
                        count: city.count),
                ],
              ],
            ),
          AsyncError() => _SheetMessage(
              text: s.locationsLoadFailed,
              onRetry: () => ref.invalidate(eventLocationsUCProvider),
            ),
          _ => const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
        },
      ),
    );
  }
}

class _SheetMessage extends StatelessWidget {
  final String text;
  final VoidCallback onRetry;

  const _SheetMessage({required this.text, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Text(text, textAlign: TextAlign.center),
          TextButton(onPressed: onRetry, child: Text(S.of(context).retry)),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/create_event_uc.dart';
import '../../../generated/l10n.dart';
import '../../themes/colors/colors.dart';
import '../../utils/form_validators.dart';
import 'event_detail_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Creación de eventos, solo para cuentas verificadas (botón "+" de la
/// barra inferior).
class CreateEventPage extends ConsumerStatefulWidget {
  static String get routeName => 'createEvent';

  static String get routeLocation => '/events/new';

  const CreateEventPage({super.key});

  @override
  ConsumerState<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  static const _categories = ['MUSIC', 'CAMPING', 'ADVENTURE', 'WORKSHOPS'];
  static const _costTypes = ['FREE', 'PAID', 'INVITATION', 'PRIVATE'];

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _shortDescription = TextEditingController();
  final _description = TextEditingController();
  final _place = TextEditingController();
  final _price = TextEditingController();
  final _currency = TextEditingController(text: 'USD');
  final _capacity = TextEditingController();

  DateTime? _date;
  String? _category;
  String _costType = 'FREE';
  XFile? _banner;

  /// Errores del API por campo; se borran al editar el campo.
  Map<String, List<String>> _apiErrors = const {};

  @override
  void dispose() {
    for (final controller in [
      _name,
      _shortDescription,
      _description,
      _place,
      _price,
      _currency,
      _capacity,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _apiError(String field) => _apiErrors[field]?.join('\n');

  void _clearApiError(String field) {
    if (!_apiErrors.containsKey(field)) return;
    setState(() => _apiErrors = {..._apiErrors}..remove(field));
  }

  Future<void> _pickBanner() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (image != null) setState(() => _banner = image);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _date ?? now.add(const Duration(days: 7));
    final day = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (day == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    setState(() {
      _date = DateTime(day.year, day.month, day.day, time.hour, time.minute);
      _apiErrors = {..._apiErrors}..remove('event_date');
    });
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final paid = _costType == 'PAID';
    final capacity = _capacity.text.trim();
    final result = await ref.read(createEventUCProvider.notifier).create(
      {
        'name': _name.text.trim(),
        'short_description': _shortDescription.text.trim(),
        'description': _description.text.trim(),
        'event_date': _date!.toUtc().toIso8601String(),
        'place': _place.text.trim(),
        'category': _category,
        'cost_type': _costType,
        if (paid) 'price': _price.text.trim().replaceAll(',', '.'),
        if (paid) 'currency': _currency.text.trim().toUpperCase(),
        'capacity': capacity.isEmpty ? null : int.parse(capacity),
      },
      bannerPath: _banner?.path,
    );
    if (!mounted) return;
    final s = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (result.eventId case final id?) {
      messenger.showSnackBar(SnackBar(
        content: Text(
            result.bannerFailed ? s.bannerUploadFailed : s.eventCreated),
      ));
      final router = GoRouter.of(context);
      router.pop();
      router.pushNamed(EventDetailPage.routeName,
          pathParameters: {'id': '$id'});
    } else {
      setState(() => _apiErrors = result.fieldErrors);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(result.error ?? ''),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isLoading = ref.watch(createEventUCProvider).isLoading;
    final categoryLabels = [s.catMusic, s.catCamping, s.catAdventure, s.catWorkshops];
    final costLabels = [s.costFree, s.costPaid, s.costInvitation, s.costPrivate];

    return Scaffold(
      appBar: AppBar(title: Text(s.createEvent)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _BannerPicker(
              banner: _banner,
              addLabel: s.addBanner,
              changeLabel: s.changeBanner,
              onTap: isLoading ? null : _pickBanner,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _name,
              maxLength: 60,
              decoration: InputDecoration(labelText: s.eventName),
              forceErrorText: _apiError('name'),
              onChanged: (_) => _clearApiError('name'),
              validator: (value) => FormValidators.required(context, value),
            ),
            TextFormField(
              controller: _shortDescription,
              maxLength: 100,
              decoration: InputDecoration(labelText: s.eventShortDescription),
              forceErrorText: _apiError('short_description'),
              onChanged: (_) => _clearApiError('short_description'),
            ),
            TextFormField(
              controller: _description,
              maxLength: 254,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(labelText: s.eventDescription),
              forceErrorText: _apiError('description'),
              onChanged: (_) => _clearApiError('description'),
            ),
            FormField<DateTime>(
              forceErrorText: _apiError('event_date'),
              validator: (_) => _date == null
                  ? s.fieldRequired
                  : _date!.isAfter(DateTime.now())
                      ? null
                      : s.dateMustBeFuture,
              builder: (field) => InkWell(
                onTap: isLoading ? null : _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: s.eventDateTime,
                    errorText: field.errorText,
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(_date == null
                      ? ''
                      : DateFormat('EEE d MMM y · HH:mm',
                              Localizations.localeOf(context).toString())
                          .format(_date!)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _place,
              maxLength: 254,
              decoration: InputDecoration(
                labelText: s.eventPlace,
                prefixIcon: const Icon(Icons.place),
              ),
              forceErrorText: _apiError('place'),
              onChanged: (_) => _clearApiError('place'),
            ),
            DropdownButtonFormField<String?>(
              initialValue: _category,
              decoration: InputDecoration(labelText: s.eventCategory),
              items: [
                DropdownMenuItem(value: null, child: Text(s.categoryNone)),
                for (final (i, code) in _categories.indexed)
                  DropdownMenuItem(value: code, child: Text(categoryLabels[i])),
              ],
              onChanged: (value) => setState(() => _category = value),
            ),
            const SizedBox(height: 20),
            Text(s.costType, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final (i, code) in _costTypes.indexed)
                  ChoiceChip(
                    label: Text(costLabels[i]),
                    selected: _costType == code,
                    selectedColor: parkeaOrange.withValues(alpha: 0.25),
                    onSelected: (_) => setState(() => _costType = code),
                  ),
              ],
            ),
            if (_costType == 'PAID')
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _price,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(labelText: s.eventPrice),
                        forceErrorText: _apiError('price'),
                        onChanged: (_) => _clearApiError('price'),
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return s.fieldRequired;
                          }
                          final price = double.tryParse(
                              (value ?? '').trim().replaceAll(',', '.'));
                          if (price == null) return s.invalidNumber;
                          return price > 0 ? null : s.pricePositive;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _currency,
                        maxLength: 3,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          labelText: s.eventCurrency,
                          counterText: '',
                        ),
                        forceErrorText: _apiError('currency'),
                        onChanged: (_) => _clearApiError('currency'),
                        validator: (value) =>
                            RegExp(r'^[A-Za-z]{3}$').hasMatch(value?.trim() ?? '')
                                ? null
                                : s.invalidCurrency,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _capacity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: s.eventCapacity,
                helperText: s.capacityHint,
              ),
              forceErrorText: _apiError('capacity'),
              onChanged: (_) => _clearApiError('capacity'),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return null;
                final capacity = int.tryParse(text);
                return capacity == null || capacity < 0
                    ? s.invalidNumber
                    : null;
              },
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 48,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: parkeaOrange),
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(s.publishEvent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Imagen cuadrada del evento (el feed la muestra 1:1).
class _BannerPicker extends StatelessWidget {
  final XFile? banner;
  final String addLabel;
  final String changeLabel;
  final VoidCallback? onTap;

  const _BannerPicker({
    required this.banner,
    required this.addLabel,
    required this.changeLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: theme.colorScheme.surfaceContainerHighest,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (banner != null)
                  Image.file(File(banner!.path), fit: BoxFit.cover),
                Align(
                  alignment: banner == null
                      ? Alignment.center
                      : Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Chip(
                      avatar: const Icon(Icons.photo_library, size: 18),
                      label: Text(banner == null ? addLabel : changeLabel),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

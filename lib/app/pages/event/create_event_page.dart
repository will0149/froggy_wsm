import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../data/dtos/event_dto.dart';
import '../../../domain/gamification/event_completeness.dart';
import '../../../domain/usecases/create_event_uc.dart';
import '../../../domain/usecases/fetch_events_uc.dart';
import '../../../generated/l10n.dart';
import '../../utils/form_validators.dart';
import '../../widgets/gamification/event_completeness_card.dart';
import 'event_detail_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Creación de eventos, solo para cuentas verificadas (botón "+" de la
/// barra inferior), o edición de uno propio si se pasa [event].
class CreateEventPage extends ConsumerStatefulWidget {
  static String get routeName => 'createEvent';

  static String get routeLocation => '/events/new';

  /// Evento a editar; null para crear uno nuevo.
  final EventDTO? event;

  const CreateEventPage({super.key, this.event});

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

  bool get _isEditing => widget.event != null;

  /// Fecha original al editar: un evento ya pasado se puede guardar sin
  /// cambiarla.
  DateTime? _originalDate;

  @override
  void initState() {
    super.initState();
    // La tarjeta de "evento completo" se actualiza mientras se escribe.
    for (final controller in [_shortDescription, _description, _place]) {
      controller.addListener(_onDetailChanged);
    }
    final event = widget.event;
    if (event == null) return;
    _name.text = event.eventName ?? '';
    _shortDescription.text = event.shortDescription ?? '';
    _description.text = event.description ?? '';
    _place.text = event.location?.place ?? '';
    _date = _originalDate = DateTime.tryParse(event.date ?? '')?.toLocal();
    _category = _categories.contains(event.category) ? event.category : null;
    if (_costTypes.contains(event.eventType)) _costType = event.eventType!;
    if (event.amount case final amount? when _costType == 'PAID') {
      final price = double.tryParse(amount.price);
      if (price != null) _price.text = NumberFormat('0.##').format(price);
      _currency.text = amount.currency;
    }
    if (event.capacity case final capacity?) _capacity.text = '$capacity';
  }

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

  void _onDetailChanged() => setState(() {});

  EventCompleteness get _completeness => EventCompleteness.of(
        hasBanner: _banner != null || widget.event?.bannerImageUrl != null,
        shortDescription: _shortDescription.text,
        description: _description.text,
        place: _place.text,
        category: _category,
      );

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
    final fields = {
      'name': _name.text.trim(),
      'short_description': _shortDescription.text.trim(),
      'description': _description.text.trim(),
      // Al editar solo se envía si cambió: el API compara con la guardada,
      // que puede tener microsegundos.
      if (_date != _originalDate)
        'event_date': _date!.toUtc().toIso8601String(),
      'place': _place.text.trim(),
      'category': _category,
      'cost_type': _costType,
      if (paid) 'price': _price.text.trim().replaceAll(',', '.'),
      if (paid) 'currency': _currency.text.trim().toUpperCase(),
      'capacity': capacity.isEmpty ? null : int.parse(capacity),
    };
    final useCase = ref.read(createEventUCProvider.notifier);
    final result = _isEditing
        ? await useCase.updateEvent(int.parse(widget.event!.id!), fields,
            bannerPath: _banner?.path)
        : await useCase.create(fields, bannerPath: _banner?.path);
    if (!mounted) return;
    final s = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (result.eventId case final id?) {
      messenger.showSnackBar(SnackBar(
        content: Text(result.bannerFailed
            ? s.bannerUploadFailed
            : _isEditing
                ? s.eventUpdated
                : s.eventCreated),
      ));
      final router = GoRouter.of(context);
      router.pop();
      if (!_isEditing) {
        router.pushNamed(EventDetailPage.routeName,
            pathParameters: {'id': '$id'});
      }
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
    final categoryLabels = [
      s.catMusic,
      s.catCamping,
      s.catAdventure,
      s.catWorkshops
    ];
    final costLabels = [
      s.costFree,
      s.costPaid,
      s.costInvitation,
      s.costPrivate
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? s.editEvent : s.createEvent)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _BannerPicker(
              banner: _banner,
              currentUrl: widget.event?.bannerImageUrl,
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
                  : _date!.isAfter(DateTime.now()) || _date == _originalDate
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
                        validator: (value) => RegExp(r'^[A-Za-z]{3}$')
                                .hasMatch(value?.trim() ?? '')
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
            const SizedBox(height: 20),
            EventCompletenessCard(completeness: _completeness),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.onPrimary),
                      )
                    : Text(_isEditing ? s.saveChanges : s.publishEvent),
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

  /// Banner actual del evento que se edita.
  final String? currentUrl;
  final String addLabel;
  final String changeLabel;
  final VoidCallback? onTap;

  const _BannerPicker({
    required this.banner,
    this.currentUrl,
    required this.addLabel,
    required this.changeLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = banner != null || currentUrl != null;
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
                  Image.file(File(banner!.path), fit: BoxFit.cover)
                else if (currentUrl != null)
                  CachedNetworkImage(imageUrl: currentUrl!, fit: BoxFit.cover),
                Align(
                  alignment:
                      hasImage ? Alignment.bottomRight : Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Chip(
                      avatar: const Icon(Icons.photo_library, size: 18),
                      label: Text(hasImage ? changeLabel : addLabel),
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

/// Edición de un evento propio. Carga el evento por id para que la ruta no
/// dependa de pasarle el objeto.
class EditEventPage extends ConsumerWidget {
  static String get routeName => 'editEvent';

  static String get routeLocation => '/events/:id/edit';

  final int eventId;

  const EditEventPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(fetchEventDetailUCProvider(eventId))) {
      AsyncValue(:final value?) => CreateEventPage(event: value),
      AsyncError(:final error) => Scaffold(
          appBar: AppBar(),
          body: Center(child: Text('$error')),
        ),
      _ => const Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()),
        ),
    };
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../device/utils/logger_config.dart';
import '../dtos/dimensions_dto.dart';
import '../models/entry_form_view_state.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/05/24

//TODO: Use Notifier or AsyncNotifier in favor of StateNotifier/ChangeNotifier.

class EntryFormViewNotifier extends AutoDisposeNotifier<EntryFormViewState> {
  String selectedPerson = " ";
  String selectedWarehouse = " ";

  String selectedDate = " ";

  String expirationDate = " ";
  bool isChecked = false;
  String seriesLength = "0";
  DimensionsDto dimensions = DimensionsDto(height: "0", width: "0", long: "0");
  bool isBadStateItem = false;
  bool isSeries = false;
  bool isValid = false;
  bool isLoading = false;

  List<String> seriesList = [];

  bool componentsLoading = true;

  @override
  EntryFormViewState build() {
    return EntryFormViewState();
  }

  void setSelectedWarehouse(String value) {
    selectedWarehouse = value;
    setState();
  }

  void setSelectedPerson(String value) {
    selectedPerson = value;
    setState();
  }

  void setSelectedDate(String value) {
    selectedDate = value;
    setState();
  }

  void setExpirationDate(String value) {
    expirationDate = value;
    setState();
  }

  void setIsChecked(bool value) {
    isChecked = value;
    setState();
  }

  void setSeriesLength(String value) {
    seriesLength = value;
    setState();
  }

  void setDimensions(DimensionsDto value) {
    dimensions = value;
    setState();
  }

  void setIsSeries(bool value) async {
    isSeries = value;
    setState();
  }

  void setBadStateItem(bool value) {
    isBadStateItem = value;
    setState();
  }

  void setIsValid(bool value) {
    isValid = value;
    setState();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    setState();
  }

  void setSeriesList(List<String> value) {
    seriesList = value;
    setState();
  }

  void setComponentsLoading(bool value) {
    componentsLoading = value;
    setState();
  }

  void setState() {
    logger.d("current value valid ${state.isValid}");
    state = EntryFormViewState(
        selectedPerson: selectedPerson,
        selectedWarehouse: selectedWarehouse,
        selectedDate: selectedDate,
        expirationDate: expirationDate,
        isChecked: isChecked,
        seriesLength: seriesLength,
        dimensions: dimensions,
        isBadStateItem: isBadStateItem,
        isSeries: isSeries,
        isValid: isValid,
        isLoading: isLoading,
        seriesList: seriesList,
        componentsLoading: componentsLoading);
  }
}

final entryFormViewProvider =
    AutoDisposeNotifierProvider<EntryFormViewNotifier, EntryFormViewState>(() {
  return EntryFormViewNotifier();
});

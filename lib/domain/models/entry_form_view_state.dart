import '../dtos/dimensions_dto.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 07/05/24
class EntryFormViewState {

  final String selectedPerson;
  final String selectedWarehouse;
  late final String selectedDate;
  late final String expirationDate;
  final bool isChecked;
  final String seriesLength;
  final DimensionsDto? dimensions;
  final bool isBadStateItem;
  final bool isSeries;
  final bool isValid;
  final bool isLoading;
  final List<String> seriesList;
  final bool componentsLoading;

  EntryFormViewState(
      {this.selectedPerson = "",
      this.selectedWarehouse = "",
      this.selectedDate="",
      this.expirationDate="",
      this.isChecked = false,
      this.seriesLength = "0",
      this.dimensions,
        this.isBadStateItem = false,
      this.isSeries = false,
      this.isValid = false,
      this.isLoading = false,
      this.seriesList = const [],
      this.componentsLoading = true});
}

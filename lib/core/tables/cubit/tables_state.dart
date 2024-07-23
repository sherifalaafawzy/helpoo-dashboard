part of 'tables_cubit.dart';

@immutable
abstract class TablesState {}

class TablesInitial extends TablesState {}

class SelectTableDate extends TablesState {}

class ChangeTableStatus extends TablesState {}

class ChangeTableItemPerPage extends TablesState {}

class ChangeTableSearchValue extends TablesState {}

class ChangeTableItemsSubList extends TablesState {}

class ChangeTableCurrentPage extends TablesState {}

class ChangeTableDateRange extends TablesState {}

class ChangeTableItemStatus extends TablesState {}

class DeleteTableItem extends TablesState {}

class ChangeTableSort extends TablesState {}

class ChangeTableSelectedItem extends TablesState {}

class IsSingleItemSelectedState extends TablesState {}

class ChangeUsageState extends TablesState {}

class ChangePopupItemActiveState extends TablesState {}

class CreateCategorySuccess extends TablesState {}

class CreateCategoryError extends TablesState {
  final String error;

  CreateCategoryError({required this.error});
}

class CreateCategoryLoading extends TablesState {}

class ClearFieldsState extends TablesState {}

class SetCategoryFieldsState extends TablesState {}

class SetCouponFieldsState extends TablesState {}

class SetOfferFieldsState extends TablesState {}

class SetSelectedProductsState extends TablesState {}

class SetSelectedProductState extends TablesState {}

class SetPropertiesFieldsSuccess extends TablesState {}

class GetCategoriesLoading extends TablesState {}

class GetCategoriesSuccess extends TablesState {}

class GetCategoriesError extends TablesState {
  final String error;

  GetCategoriesError({required this.error});
}

class CreatePropertyLoading extends TablesState {}

class CreatePropertySuccess extends TablesState {}

class CreatePropertyError extends TablesState {
  final String error;

  CreatePropertyError({required this.error});
}

class GetPropertiesLoading extends TablesState {}

class GetPropertiesSuccess extends TablesState {}

class GetPropertiesError extends TablesState {
  final String error;

  GetPropertiesError({required this.error});
}

class GetProductsLoading extends TablesState {}

class GetProductsSuccess extends TablesState {}

class GetProductsError extends TablesState {
  final String error;

  GetProductsError({required this.error});
}

class CustomerListLoading extends TablesState {}

class CustomerListSuccess extends TablesState {}

class CustomersTableRowsChanged extends TablesState {}

class CustomerListError extends TablesState {
  final String error;

  CustomerListError({required this.error});
}

class DeleteCategoryLoading extends TablesState {}

class DeleteCategorySuccess extends TablesState {
  final String categoryId;

  DeleteCategorySuccess({required this.categoryId});
}

class DeleteCategoryError extends TablesState {
  final String error;

  DeleteCategoryError({required this.error});
}

class DeletePropertyLoading extends TablesState {}

class DeletePropertySuccess extends TablesState {
  final String propertyId;

  DeletePropertySuccess({required this.propertyId});
}

class DeletePropertyError extends TablesState {
  final String error;

  DeletePropertyError({required this.error});
}

class UpdateCategoryLoading extends TablesState {}

class UpdateCategorySuccess extends TablesState {
  final String categoryId;

  UpdateCategorySuccess({required this.categoryId});
}

class UpdateCategoryError extends TablesState {
  final String error;

  UpdateCategoryError({required this.error});
}

class UpdatePropertyLoading extends TablesState {}

class UpdatePropertySuccess extends TablesState {
  final String propertyId;

  UpdatePropertySuccess({required this.propertyId});
}

class UpdatePropertyError extends TablesState {
  final String error;

  UpdatePropertyError({required this.error});
}

class GetCustomersLoading extends TablesState {}

class GetCustomersSuccess extends TablesState {}

class GetCustomersError extends TablesState {
  final String error;

  GetCustomersError({required this.error});
}

class EmployeeSetDataLoading extends TablesState {}

class EmployeeListLoading extends TablesState {}

class EmployeeListSuccess extends TablesState {}

class ActivationChanged extends TablesState {}

class EmployeeListError extends TablesState {
  final String error;

  EmployeeListError({required this.error});
}

class ReorderItems extends TablesState {}

class SetIndexDriver extends TablesState {}

class AdminRulesChanged extends TablesState {}

class CreateEmployeeValidationToggled extends TablesState {}

class PasswordVisibilityChanged extends TablesState {}

class CreateEmployeeLoading extends TablesState {}

class CreateEmployeeSuccess extends TablesState {}

class CreateEmployeeError extends TablesState {
  final String error;

  CreateEmployeeError({required this.error});
}

class GetOrdersLoading extends TablesState {}

class GetOrdersSuccess extends TablesState {}

class GetOrdersError extends TablesState {
  final String error;

  GetOrdersError({required this.error});
}

class SelectedOrderDetailsModelChanged extends TablesState {}

class SelectedOrderDetailsDocRefChanged extends TablesState {}

class SetDateTimeControllerFromToSuccess extends TablesState {}

class CreateCouponLoading extends TablesState {}

class CreateCouponError extends TablesState {
  final String error;

  CreateCouponError({required this.error});
}

class GetCouponsLoading extends TablesState {}

class GetCouponsSuccess extends TablesState {}

class GetCouponsError extends TablesState {
  final String error;

  GetCouponsError({required this.error});
}

class UpdateCouponLoading extends TablesState {}

class UpdateCouponSuccess extends TablesState {
  final String couponId;

  UpdateCouponSuccess({required this.couponId});
}

class UpdateCouponError extends TablesState {
  final String error;

  UpdateCouponError({required this.error});
}

class DeleteCouponLoading extends TablesState {}

class DeleteCouponSuccess extends TablesState {
  final String couponId;

  DeleteCouponSuccess({required this.couponId});
}

class DeleteCouponError extends TablesState {
  final String error;

  DeleteCouponError({required this.error});
}

class CreateOfferLoading extends TablesState {}

class CreateOfferError extends TablesState {
  final String error;

  CreateOfferError({required this.error});
}

class GetOffersLoading extends TablesState {}

class GetOffersSuccess extends TablesState {}

class GetOffersError extends TablesState {
  final String error;

  GetOffersError({required this.error});
}

class UpdateOrderLoading extends TablesState {}

class UpdateOrderSuccess extends TablesState {}

class UpdateOrderError extends TablesState {
  final String error;

  UpdateOrderError({required this.error});
}

class UpdateOfferLoading extends TablesState {}

class UpdateOfferSuccess extends TablesState {
  final String offerId;

  UpdateOfferSuccess({required this.offerId});
}

class UpdateOfferError extends TablesState {
  final String error;

  UpdateOfferError({required this.error});
}

class DeleteOfferLoading extends TablesState {}

class DeleteOfferSuccess extends TablesState {
  final String offerId;

  DeleteOfferSuccess({required this.offerId});
}

class DeleteOfferError extends TablesState {
  final String error;

  DeleteOfferError({required this.error});
}

class CurrentTableChanged extends TablesState {}

class SelectedOrderProductModelChanged extends TablesState {}

class SearchInProductsSuccess extends TablesState {}

class FilterProductsByDateRangeSuccess extends TablesState {}

class SearchCategoriesSuccess extends TablesState {}

class FilterCategoriesByDateRangeSuccess extends TablesState {}

class SearchInOffersSuccess extends TablesState {}

class FilterOffersByDateRangeSuccess extends TablesState {}

class GetTableItemsWidgets extends TablesState {}

class SetSelectedEmployeeRole extends TablesState {}

class SetOrdersStatusSelected extends TablesState {}

class GetCompletedOrdersSuccess extends TablesState {}

class SearchInSelectionPopup extends TablesState {}

class SelectedCouponStatusValue extends TablesState {}

class SelectedOffersTableStatusChanged extends TablesState {}

class FilterOffersByStatusSuccess extends TablesState {}

class SearchInFinancialTableSuccess extends TablesState {}

class ClearSearchValueSuccess extends TablesState {}

class UpdateCouponStatusLoading extends TablesState {}

class UpdateCouponStatusError extends TablesState {}

class UpdateCouponStatusSuccess extends TablesState {}

part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class ProductChangeEvent extends ExploreEvent {
  const ProductChangeEvent({required this.product});
  final List<Product> product;
}

class NewArrivalsChangeEvent extends ExploreEvent {
  const NewArrivalsChangeEvent({required this.newArrivals});
  final List<Product> newArrivals;
}

class CatagoryChangeEvent extends ExploreEvent {
  const CatagoryChangeEvent({required this.catagory});
  final int catagory;
}

class EditProdcutEvent extends ExploreEvent {
  const EditProdcutEvent({required this.productId, required this.data});
  final String productId;
  final Map<String, dynamic> data;
}

class DeleteProductEvent extends ExploreEvent {
  const DeleteProductEvent({required this.productId});
  final String productId;
}

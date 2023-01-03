part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  const ExploreState(
      {this.newArrivals = const [],
      this.product = const [],
      this.catagory = 1});
  final List<Product> product;
  final List<Product> newArrivals;
  final int catagory;

  @override
  List<Object> get props => [product, newArrivals, catagory];

  ExploreState copyWith({product, newArrivals, catagory}) {
    return ExploreState(
        catagory: catagory ?? this.catagory,
        product: product ?? this.product,
        newArrivals: newArrivals ?? this.newArrivals);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/product_model.dart';
import 'package:kelompok9_toko_online/services/product_services.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc(this.productService) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}

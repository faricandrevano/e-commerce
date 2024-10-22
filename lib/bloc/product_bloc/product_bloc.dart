import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kelompok9_toko_online/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        QuerySnapshot querySnapshot = await products.get();
        List<Product> productsData = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Product.fromJson(data);
        }).toList();
        emit(ProductLoaded(productsData));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<SearchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final title = event.title.toLowerCase();

        final category = event.category?.toLowerCase();
        // final products = await productService.fetchProducts();
        QuerySnapshot queryProducts = await products.get();
        List<Product> resultProduct = [];
        final List<Product> productData = queryProducts.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Product.fromJson(data);
        }).toList();
        if (category != null) {
          resultProduct = productData
              .where((product) => product.title.toLowerCase().contains(title))
              .where(
                  (product) => product.category.toLowerCase() == event.category)
              .toList();
        } else {
          resultProduct = productData
              .where(
                (product) => product.title.toLowerCase().contains(title),
              )
              .toList();
        }
        if (resultProduct.isEmpty) {
          emit(ProductNothing());
        } else {
          emit(ProductSearchLoaded(resultProduct));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<RefreshProduct>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(const Duration(seconds: 2));
      try {
        QuerySnapshot querySnapshot = await products.get();
        List<Product> productsData = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Product.fromJson(data);
        }).toList();
        emit(ProductLoaded(productsData));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:exam/src/data/model/product/product.dart';
import 'package:exam/src/data/repository/product_repository.dart';
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../widget_test.dart';

class MockProductRepository extends Mock
    implements ProductRepository {}

class MockProduct extends Mock implements Product {}


void main() {
  final mockProducts = [
  Product(1, "title", "description", 10, 10, 1, 10, "brand", "category", "thumbnail", const []),
  Product(2, "title", "description", 10, 10, 1, 10, "brand", "category", "thumbnail", const [])];

  setUpAll(() {
    setupDependencyInjection();
  });

  group("PostFetched", () {
    blocTest<ProductBloc, ProductState>(
      'emits nothing when product has reached maximum amount',
      build: () => ProductBloc(),
      seed: () => const ProductState(hasReachedMax: true),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => <ProductState>[],
    );
  });
}
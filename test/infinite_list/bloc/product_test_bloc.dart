import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:exam/src/data/model/product/product.dart';
import 'package:exam/src/data/repository/product_repository.dart';
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../widget_test.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductBloc', () {
    final mockProducts = [
      Product(
          1,
          "title",
          "description",
          10,
          10,
          1,
          10,
          "brand",
          "category",
          "thumbnail",
          const []),
      Product(
          2,
          "title",
          "description",
          10,
          10,
          1,
          10,
          "brand",
          "category",
          "thumbnail",
          const [])
    ];

    setUpAll(() {
      setupDependencyInjection();
    });

    setUp(() {

    });

    test('initial state is ProductState()', () {
      expect(ProductBloc().state, const ProductState());
    });


    group("PostFetched", () {
      blocTest<ProductBloc, ProductState>(
        'emits nothing when posts has reached maximum amount',
        build: () => ProductBloc(),
        seed: () => const ProductState(hasReachedMax: true),
        act: (bloc) => bloc.add(ProductFetched(1)),
        expect: () => <ProductState>[],
      );

      blocTest<ProductBloc, ProductState>(
        'emits successful status when fetches product success',
        build: () => ProductBloc(),
        act: (bloc) async {
          bloc.add(ProductFetched(2));
          await Future<void>.delayed(const Duration(seconds: 3));
        },
        expect: () => [isA<ProductState>().having((p0) => p0.status, "", LazyLoadStatus.success)]
      );

      blocTest<ProductBloc, ProductState>(
          'emits product length equal 2 when request limit 2',
          build: () => ProductBloc(),
          act: (bloc) async {
            bloc.add(ProductFetched(2));
            await Future<void>.delayed(const Duration(seconds: 3));
          },
          expect: () => [isA<ProductState>().having((p0) => p0.products.length, "", 2)]
      );

    });
  });
}
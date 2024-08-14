import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
    Future <ProductModel> get_products();
    Future <ProductModel> get_product_by_id();
    Future <ProductModel> update_products();
    Future <ProductModel> delete_products();
    Future <ProductModel> insert_products();

}
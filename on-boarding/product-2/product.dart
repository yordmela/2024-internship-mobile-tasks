import 'dart:io';

void main(){
  List <Product> productList=[];
  var productManager= ProductManger(productList);

  while(true){
    print("type 1 for adding product");
    print("type 2 for view all product");
    print("type 3 for view single product");
    print("type 4 for editing product");
    print("type 5 for deleting product");

    int ? option= int.parse(stdin.readLineSync()!);

    switch(option){
      case 1:
           stdout.write('Please enter the product name: ');
            var name= stdin.readLineSync();

            stdout.write('please enter the product description: ');
            var desc= stdin.readLineSync();
            
            stdout.write('please enter the product price: ');
            var price= getPriceFromUser();

            if(name!=null && desc!=null && price!=null){
            productManager.addProduct(name,desc,price);
            print("successfully created");
            }else{
              print('invalid input');
            }
            
         

      case 2:
           productManager.viewallProducts();
           

      case 3:
            stdout.write("enter the product name: ");
            var product_name= stdin.readLineSync();
            productManager.viewProduct(product_name);
      
      case 4:

            stdout.write('Please enter the product name you want to edit: ');
            var product_name= stdin.readLineSync();

            stdout.write('Please enter the new product name: ');
            var name= stdin.readLineSync();

            stdout.write('please enter the new product description: ');
            var desc= stdin.readLineSync();
            
            stdout.write('please enter the new product price: ');
            var price= getPriceFromUser();

          
          

            productManager.editProduct(product_name,name,desc,price);
            

      case 5:
            stdout.write('Please enter the product name you want to delete: ');
            var product_name= stdin.readLineSync();

            productManager.deleteProduct(product_name);

      default:
           print('no such option');           
    }
  }
    

}


int getPriceFromUser() {
  var flag=true;
  while (flag) {
    var priceInput = stdin.readLineSync();
    try {
      return int.parse(priceInput!);
    } catch (e) {
      print('Invalid input. Please enter a valid number.');

    }
  }
}

class Product{
    String ? name;
    String ? description;
    int ? price;

    Product(String name, description, int price){
      this.name= name;
      this.description= description;
      this.price= price;
    }

    @override
    String toString(){
      return 'name: $name, description: $description, price: $price';
    }

}




class ProductManger {
   List products;
   ProductManger(this.products);
    
    void addProduct(name, desc, price){
        Product pro= Product(name, desc, price);
        products.add(pro);
    }

    void viewallProducts(){
       print(products);
    }

    void viewProduct(product_name){
      var flag= false;
      for (Product pro in products){
        if (pro.name==product_name){
          print(pro);
          flag= true;
          break;
        }
      }
      if (! flag) {
          print('this product does not exist');
      }
      
    }

    void editProduct(product_name, [name, desc, price]){
               var flag=false;
               for (Product pro in products){
                if (pro.name==product_name){
                  if(name!=null && name!=""){
                  pro.name= name;
                  }
                  if (desc!=null && name!=""){
                  pro.description= desc;
                  }
                  if(price!=null && name!=""){
                  pro.price= price;
                  }
                flag=true;
                break;
                  
                }

               
               }
                if (!flag){
                  print('no such product');
                }

               
    }
    void deleteProduct(product_name){
      var flag= false;
      for (Product product in products){
        if (product_name== product.name){
            products.remove(product);
            flag= true;
            print("successfully deleted");
            break;
        }
      }
      if (!flag){
        print("no such product");
      }
      
    }


}

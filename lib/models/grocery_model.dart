class GroceryModel {
  final String name;
  final double price;
  final double rating;
  final String desc;
  final String imageAsset;

  GroceryModel({
    required this.name,
    required this.price,
    required this.rating,
    required this.desc,
    required this.imageAsset,
  });
}

List<GroceryModel> groceryList = [
  GroceryModel(
    name: 'Farm Fresh Veggie Box',
    price: 10.0,
    rating: 4.3,
    desc: 'Curated box of local produce',
    imageAsset: 'assets/images/grocery1.png',
  ),
  GroceryModel(
    name: 'Grain Essentials',
    price: 8.0,
    rating: 4.0,
    desc: 'Assorted grains for baking',
    imageAsset: 'assets/images/grocery2.png',
  ),
  GroceryModel(
    name: 'Organic Fruit Basket',
    price: 13.0,
    rating: 4.7,
    desc: 'Hand-picked organics',
    imageAsset: 'assets/images/grocery3.png',
  ),
  GroceryModel(
    name: 'Artisan Bakery Pack',
    price: 6.5,
    rating: 4.1,
    desc: 'Fresh breads, buns',
    imageAsset: 'assets/images/grocery4.png',
  ),
  GroceryModel(
    name: 'Butcher’s Best Meats',
    price: 17.0,
    rating: 4.5,
    desc: 'Quality fresh meats',
    imageAsset: 'assets/images/grocery5.png',
  ),
  GroceryModel(
    name: 'Fresh Herbs Bundle',
    price: 3.2,
    rating: 4.8,
    desc: 'Aromatic herbs',
    imageAsset: 'assets/images/grocery6.png',
  ),
];

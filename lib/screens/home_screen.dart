import 'package:flutter/material.dart';
import '../models/grocery_model.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDark;

  const HomeScreen({
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  final List<String> categories = [
    'Meats', 'Fresh', 'Bakery', 'Grains', 'Organic', 'Fruits'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Liked'),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(10),
            children: [
              // Delivery Location Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.red, size: 18),
                      SizedBox(width: 4),
                      Text("Deliver to:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      SizedBox(width: 2),
                      Text("Your Home", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                ],
              ),
              const SizedBox(height: 8),

              // Category Chips
              SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, idx) => ChoiceChip(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 1),
                      child: Text(categories[idx], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    selected: selectedCategory == idx,
                    selectedColor: Colors.green[200],
                    backgroundColor: Colors.grey[200],
                    onSelected: (selected) => setState(() => selectedCategory = idx),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search groceries, categories...',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 7),

              Text(
                "Groceries",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green[800], letterSpacing: 0.5),
              ),
              const SizedBox(height: 7),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: groceryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (ctx, i) {
                  final grocery = groceryList[i];
                  return _SmallGroceryTile(grocery: grocery);
                },
              ),
              const SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallGroceryTile extends StatefulWidget {
  final GroceryModel grocery;
  const _SmallGroceryTile({required this.grocery});

  @override
  State<_SmallGroceryTile> createState() => _SmallGroceryTileState();
}

class _SmallGroceryTileState extends State<_SmallGroceryTile> {
  bool _hovering = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: _hovering
            ? (Matrix4.identity()..scale(1.035))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          boxShadow: _hovering
              ? [BoxShadow(color: Colors.black26, blurRadius: 7, offset: Offset(0, 2))]
              : [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(grocery: widget.grocery),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // LARGER, SQUARE IMAGE (90x90px)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset(
                      widget.grocery.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) =>
                        Icon(Icons.image, size: 30, color: Colors.grey[400]),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.grocery.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5, height: 1.13),
                  maxLines: 2,
                ),
                Text(
                  widget.grocery.desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 10.8),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${widget.grocery.price}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 0.7, horizontal: 1.5),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            iconSize: 12,
                            splashRadius: 13,
                            visualDensity: VisualDensity.compact,
                            color: Colors.green,
                            onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10.5),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            iconSize: 12,
                            splashRadius: 13,
                            visualDensity: VisualDensity.compact,
                            color: Colors.green,
                            onPressed: () => setState(() => quantity++),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2.5),
                    Expanded(
                      child: SizedBox(
                        height: 28,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.shopping_cart, size: 13),
                          label: const Text('Cart', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                            minimumSize: const Size(27, 28),
                            padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added ${widget.grocery.name} (x$quantity) to cart!')),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

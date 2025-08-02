import 'package:flutter/material.dart';
import '../models/grocery_model.dart';

class DetailScreen extends StatelessWidget {
  final GroceryModel grocery;

  const DetailScreen({Key? key, required this.grocery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(grocery.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {/* Favorite logic if needed */},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Hero(
            tag: grocery.imageAsset,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                grocery.imageAsset,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            grocery.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            grocery.desc,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.attach_money, color: Colors.green[800]),
              Text('${grocery.price}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 22),
              Icon(Icons.star, color: Colors.orange[800]),
              Text('${grocery.rating}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                icon: const Icon(Icons.home),
                label: const Text('Home'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

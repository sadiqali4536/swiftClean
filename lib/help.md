booking page function

onPressed: () async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  double originalPrice = 1800;
  int discountPercent = 20;
  double totalPrice = originalPrice - (originalPrice * discountPercent / 100);

  await FirebaseFirestore.instance
      .collection('carts')
      .doc(uid)
      .collection('items')
      .add({
    'garden_size': _currentSliderValue,
    'original_price': originalPrice,
    'discount_percent': discountPercent,
    'price': totalPrice,
    'quantity': 1,
    'product_name': 'Garden Cleaning',
    'product_image': 'https://i.imgur.com/8QfQ9eB.jpg',
    'product_id': '1',
    'product_type': 'Exterior',
    'selected_date': formattedDate,
    'selected_time': formattedTime,
    'timestamp': FieldValue.serverTimestamp(),
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Garden Cleaning added to cart")),
  );

  // Removed: Navigator.push to cart
},


cartpage

 Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Cart")),
        body: const Center(child: Text("User not logged in")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('carts')
            .doc(uid)
            .collection('items')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Your cart is empty."));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              final productName = data['product_name'] ?? 'Unknown';
              final productImage = data['product_image'] ?? '';
              final originalPrice = (data['original_price'] ?? 0).toDouble();
              final discountPercent = (data['discount_percent'] ?? 0).toDouble();
              final discountedPrice = originalPrice - (originalPrice * discountPercent / 100);

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: productImage.isNotEmpty
                      ? Image.network(productImage, width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image),
                  title: Text(productName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Original Price: ₹${originalPrice.toStringAsFixed(2)}"),
                      Text("Discount: ${discountPercent.toStringAsFixed(0)}%"),
                      Text(
                        "Total: ₹${discountedPrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      docs[index].reference.delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$productName removed from cart')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
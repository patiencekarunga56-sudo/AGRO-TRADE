import 'package:flutter/material.dart';
class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedNavIndex = 0;
  
  // Dynamic Cart State: Map of Product Name -> {price, count, image}
  final Map<String, Map<String, dynamic>> _cartItems = {};

  void _addToCart(String name, int price, String image) {
    setState(() {
      if (_cartItems.containsKey(name)) {
        _cartItems[name]!['count'] += 1;
      } else {
        _cartItems[name] = {'price': price, 'count': 1, 'image': image};
      }
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added to cart!'),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF2E7D32),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () => setState(() => _selectedNavIndex = 2),
        ),
      ),
    );
  }

  void _updateCartCount(String name, int change) {
    setState(() {
      if (_cartItems.containsKey(name)) {
        _cartItems[name]!['count'] += change;
        if (_cartItems[name]!['count'] <= 0) {
          _cartItems.remove(name);
        }
      }
    });
  }

  int get _cartTotalItemCount {
    int total = 0;
    _cartItems.forEach((key, item) => total += (item['count'] as int));
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CustomerHomeContent(onAddToCart: _addToCart),
      const Center(child: Text("Categories Screen", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      CartScreenBody(cartItems: _cartItems, onUpdateCount: _updateCartCount),
      const CustomerOrdersContent(),
      const Center(child: Text("Profile Page", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    ];

    return Scaffold(
      body: SafeArea(
        child: pages[_selectedNavIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: _cartTotalItemCount > 0,
              label: Text('$_cartTotalItemCount'),
              backgroundColor: const Color(0xFF2E7D32),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

/// 1. HOME TAB CONTENT (With Functional Filtering & Add-To-Cart)
class CustomerHomeContent extends StatefulWidget {
  final Function(String name, int price, String image) onAddToCart;

  const CustomerHomeContent({super.key, required this.onAddToCart}); 

  @override
  State<CustomerHomeContent> createState() => _CustomerHomeContentState();
}

class _CustomerHomeContentState extends State<CustomerHomeContent> {
  String _selectedCategory = 'Vegetables';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _allProducts = [
    {'name': 'Tomatoes', 'price': 4000, 'category': 'Vegetables', 'image': 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&w=300&q=80'},
    {'name': 'Onions', 'price': 3500, 'category': 'Vegetables', 'image': 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?auto=format&fit=crop&w=300&q=80'},
    {'name': 'Potatoes', 'price': 2800, 'category': 'Vegetables', 'image': 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?auto=format&fit=crop&w=300&q=80'},
    {'name': 'Apples', 'price': 6000, 'category': 'Fruits', 'image': 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=300&q=80'},
    {'name': 'Bananas', 'price': 3000, 'category': 'Fruits', 'image': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?auto=format&fit=crop&w=300&q=80'},
    {'name': 'Maize', 'price': 2500, 'category': 'Grains', 'image': 'https://images.unsplash.com/photo-1551754655-cd27e38d2076?auto=format&fit=crop&w=300&q=80'},
    {'name': 'Kidney Beans', 'price': 5000, 'category': 'Legumes', 'image': 'https://images.unsplash.com/photo-1551462147-ff29053bfc14?auto=format&fit=crop&w=300&q=80'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Vegetables', 'icon': Icons.grass},
    {'label': 'Fruits', 'icon': Icons.apple},
    {'label': 'Grains', 'icon': Icons.grain},
    {'label': 'Legumes', 'icon': Icons.spa},
    {'label': 'Others', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _allProducts
        .where((p) => _selectedCategory == 'Others' || p['category'] == _selectedCategory)
        .toList();

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.eco, color: Color(0xFF2E7D32)),
                  SizedBox(width: 4),
                  Text('AgroTrade', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              const Icon(Icons.notifications_none),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Hello, Customer 👋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Find fresh produce from our local farmers', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.tune),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          // Banner Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fresh Produce Direct from Farmers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      const Text('Support local farmers and get the best quality', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          _scrollController.animateTo(
                            320,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2E7D32),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=300&q=80',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Category Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: Color(0xFF2E7D32)))),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat['label'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat['label']),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(cat['icon'], color: isSelected ? Colors.white : const Color(0xFF2E7D32), size: 22),
                        const SizedBox(height: 4),
                        Text(cat['label'], style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // Products Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Featured Products ($_selectedCategory)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: Color(0xFF2E7D32)))),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(product['image'], width: double.infinity, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('UGX ${product['price']}/kg', style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => widget.onAddToCart(product['name'], product['price'], product['image']),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xFF2E7D32),
                          child: Icon(Icons.add, size: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// 2. CART SCREEN BODY
class CartScreenBody extends StatelessWidget {
  final Map<String, Map<String, dynamic>> cartItems;
  final Function(String name, int change) onUpdateCount;

  const CartScreenBody({super.key, required this.cartItems, required this.onUpdateCount});

  int get _cartTotal {
    int sum = 0;
    cartItems.forEach((_, item) {
      sum += (item['price'] as int) * (item['count'] as int);
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
            Text('Add items from the Home tab', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Shopping Cart', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: cartItems.entries.map((entry) {
                final name = entry.key;
                final data = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(data['image'], width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text('UGX ${data['price']}/kg', style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
                            onPressed: () => onUpdateCount(name, -1),
                          ),
                          Text('${data['count']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2E7D32)),
                            onPressed: () => onUpdateCount(name, 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Amount', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text('UGX $_cartTotal', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order placed successfully!'), backgroundColor: Color(0xFF2E7D32)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Checkout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 3. ORDERS TAB CONTENT
class CustomerOrdersContent extends StatefulWidget {
  const CustomerOrdersContent({super.key});

  @override
  State<CustomerOrdersContent> createState() => _CustomerOrdersContentState();
}

class _CustomerOrdersContentState extends State<CustomerOrdersContent> {
  int _selectedFilter = 0;
  final List<String> _filters = ["All", "Pending", "Accepted", "Delivered"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Orders', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: List.generate(_filters.length, (index) {
              final isSelected = _selectedFilter == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedFilter = index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _filters[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _orderCard(
                  orderId: '#AGT001',
                  dateTime: '10 Oct 2026, 10:24 AM',
                  items: 'Tomatoes (5 kg), Onions (2 kg)',
                  total: 'UGX 32,000',
                  status: 'Pending',
                  statusBgColor: const Color(0xFFFFF3E0),
                  statusTextColor: const Color(0xFFE65100),
                  imgUrl: 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&w=200&q=80',
                ),
                _orderCard(
                  orderId: '#AGT002',
                  dateTime: '11 Oct 2026, 04:15 PM',
                  items: 'Maize (10 kg), Beans (5 kg)',
                  total: 'UGX 45,000',
                  status: 'Accepted',
                  statusBgColor: const Color(0xFFE8F5E9),
                  statusTextColor: const Color(0xFF2E7D32),
                  imgUrl: 'https://images.unsplash.com/photo-1551754655-cd27e38d2076?auto=format&fit=crop&w=200&q=80',
                ),
                _orderCard(
                  orderId: '#AGT003',
                  dateTime: '12 Oct 2026, 09:30 AM',
                  items: 'Potatoes (15 kg), Tomatoes (2 kg)',
                  total: 'UGX 58,000',
                  status: 'Delivered',
                  statusBgColor: const Color(0xEFE1F5FE),
                  statusTextColor: const Color(0xFF0288D1),
                  imgUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?auto=format&fit=crop&w=200&q=80',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderCard({
    required String orderId,
    required String dateTime,
    required String items,
    required String total,
    required String status,
    required Color statusBgColor,
    required Color statusTextColor,
    required String imgUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order $orderId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBgColor, borderRadius: BorderRadius.circular(12)),
                child: Text(status, style: TextStyle(color: statusTextColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(dateTime, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ),
          const Divider(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl, width: 45, height: 45, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text('Total: $total', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
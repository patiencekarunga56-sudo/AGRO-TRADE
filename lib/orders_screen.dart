import 'package:flutter/material.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ["All", "Pending", "Accepted", "Delivered"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter Pills Switcher
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

            // Order List items
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
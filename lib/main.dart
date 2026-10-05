import 'package:flutter/material.dart';

void main() {
  runApp(const BikeConsultancyApp());
}

class BikeConsultancyApp extends StatelessWidget {
  const BikeConsultancyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bike Hub & Finance',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// Bike Data Model
class Bike {
  final String id;
  final String name;
  final double price;
  final String location;
  final String sellerType; // "Consultancy" or "Private Seller"
  final String imageUrl;

  Bike({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.sellerType,
    required this.imageUrl,
  });

  double get downPayment30 => price * 0.30;
  double get downPayment40 => price * 0.40;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample Data
  List<Bike> bikes = [
    Bike(
      id: "1",
      name: "Royal Enfield Classic 350 (2021)",
      price: 140000,
      location: "Hanamkonda",
      sellerType: "Consultancy",
      imageUrl: "https://via.placeholder.com/300x200",
    ),
    Bike(
      id: "2",
      name: "TVS Apache RTR 160 4V",
      price: 75000,
      location: "Warangal",
      sellerType: "Private Seller",
      imageUrl: "https://via.placeholder.com/300x200",
    ),
    Bike(
      id: "3",
      name: "Hero Splendor Plus (2022)",
      price: 52000,
      location: "Kazipet",
      sellerType: "Consultancy",
      imageUrl: "https://via.placeholder.com/300x200",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bikes & Easy Finance"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bikes.length,
        itemBuilder: (context, index) {
          final bike = bikes[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.two_wheeler, size: 80, color: Colors.grey),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: bike.sellerType == "Consultancy" ? Colors.green : Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          bike.sellerType,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bike.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Location: ${bike.location}", style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text("Price: ₹ ${bike.price.toStringAsFixed(0)}",
                          style: const TextStyle(fontSize: 16, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                      const Divider(),
                      // Finance Box
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Finance Offer:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                Text("30% Down Payment: ₹${bike.downPayment30.toStringAsFixed(0)}",
                                    style: const TextStyle(fontSize: 12, color: Colors.black80)),
                                Text("40% Down Payment: ₹${bike.downPayment40.toStringAsFixed(0)}",
                                    style: const TextStyle(fontSize: 12, color: Colors.black80)),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BuyerFormScreen(bike: bike)),
                                );
                              },
                              child: const Text("Buy / Finance"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PostBikeScreen()));
        },
        backgroundColor: Colors.deepOrange,
        icon: const Icon(Icons.add_a_photo, color: Colors.white),
        label: const Text("Sell Your Bike", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

// Buyer Details Collect Chese Screen
class BuyerFormScreen extends StatefulWidget {
  final Bike bike;
  const BuyerFormScreen({super.key, required this.bike});

  @override
  State<BuyerFormScreen> createState() => _BuyerFormScreenState();
}

class _BuyerFormScreenState extends State<BuyerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedDownPayment = "30%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buyer & Finance Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bike: ${widget.bike.name}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Price: ₹${widget.bike.price.toStringAsFixed(0)}", style: const TextStyle(color: Colors.deepOrange)),
                const SizedBox(height: 20),
                const Text("Select Down Payment Plan:", style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  value: selectedDownPayment,
                  items: const [
                    DropdownMenuItem(value: "30%", child: Text("30% Down Payment")),
                    DropdownMenuItem(value: "40%", child: Text("40% Down Payment")),
                    DropdownMenuItem(value: "Full Cash", child: Text("Full Cash Payment")),
                  ],
                  onChanged: (val) => setState(() => selectedDownPayment = val!),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? "Enter your name" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v!.isEmpty ? "Enter phone number" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: "City / Location", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Details Submitted! Our team will contact you for finance approval.")),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Submit Finance Request", style: TextStyle(fontSize: 16)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// External Sellers Bike Post Chese Screen
class PostBikeScreen extends StatelessWidget {
  const PostBikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Your Bike for Sale")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TextField(decoration: InputDecoration(labelText: "Bike Brand & Model", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: "Expected Price (₹)", border: OutlineInputBorder()), keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: "Vehicle Year & KM Driven", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: "Location", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(labelText: "Seller Contact Number", border: OutlineInputBorder()), keyboardType: TextInputType.phone),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text("Upload Bike Photos"),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Bike posted successfully for review!")),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Post Bike"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

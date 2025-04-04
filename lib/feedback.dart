import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CustomerFeedbackScreen(),
    );
  }
}

class CustomerFeedbackScreen extends StatelessWidget {
  const CustomerFeedbackScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> reviews = const [
    {
      'name': 'Martin Luather',
      'rating': 4.0,
      'time': '2 days ago',
      'comment': 'Lorem Ipsum is simply dummy text of the printing...',
      'avatar': Icons.person
    },
    {
      'name': 'Johan Smith Jeo',
      'rating': 3.0,
      'time': '3 days ago',
      'comment': 'Lorem Ipsum is simply dummy text of the printing...',
      'avatar': Icons.person
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black),
                  const SizedBox(width: 10),
                  const Text(
                    "Customer Feedback",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Overall Rating",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "3.9",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < 4 ? Colors.amber : Colors.grey[400],
                          size: 30,
                        );
                      }),
                    ),
                    const SizedBox(height: 5),
                    Text("Based on 20 reviews",
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildRatingRow("Excellent", 0.6),
              _buildRatingRow("Good", 0.5),
              _buildRatingRow("Average", 0.4),
              _buildRatingRow("Poor", 0.3),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Icon(review['avatar']),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        review['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(review['time'],
                                          style: TextStyle(
                                              color: Colors.grey[600])),
                                    ],
                                  ),
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        color: index < review['rating']
                                            ? Colors.amber
                                            : Colors.grey[400],
                                        size: 16,
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    review['comment'],
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: Text("Write a review",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(label)),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

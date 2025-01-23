import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Food Delivery Tracker',
              style: TextStyle(color: Colors.white)),
          primary: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Order Details",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.hourglass_bottom_sharp,
                            size: 16.0, color: Colors.deepPurple),
                        const SizedBox(width: 5.0),
                        Text("In-progress",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.deepPurple)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Spagetti Bolognese",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5.0),
                          Text("Your delivery,",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal)),
                          Text("#78ejdhhdjs78737883747737,",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal)),
                          Text("is on the way",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(height: 10.0),
                          Text("\$15.00",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            "https://res.cloudinary.com/dtgbzmpca/image/upload/v1737422520/di8w324-73ebb36d-325a-48e5-9c01-20fec04fa02a.jpg_qb9qqu.jpg",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}

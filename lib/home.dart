import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:food_tracker/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Order> orders;
  bool _isLoading = false;
  bool _isError = false;

  //add real-time capability
  RealtimeSubscription? subscription;

  @override
  void dispose() {
    subscription?.close();
    super.dispose();
  }

  _subscribe() {
    final realtime = Realtime(FoodTrackerService().client);
    subscription = realtime.subscribe(['documents']);

    //listening to stream
    subscription!.stream.listen((data) {
      final event = data.events.first;
      if (data.payload.isNotEmpty) {
        if (event.endsWith('.update')) {
          orders
              .map((element) => element.status = data.payload['status'])
              .toList();
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    getOrders();
    _subscribe();
    super.initState();
  }

  getOrders() {
    setState(() {
      _isLoading = true;
    });
    FoodTrackerService().getFoodTracker().then((value) {
      setState(() {
        orders = value;
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.blue,
          ))
        : _isError
            ? const Center(
                child: Text(
                  'Error getting orders',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Food Delivery Tracker',
                      style: TextStyle(color: Colors.white)),
                  primary: true,
                  backgroundColor: Colors.deepPurple,
                ),
                body: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Details",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10.0),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.hourglass_bottom_sharp,
                                            size: 16.0,
                                            color: Colors.deepPurple),
                                        const SizedBox(width: 5.0),
                                        Text(orders[index].status,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.deepPurple)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(orders[index].name,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700)),
                                          const SizedBox(height: 5.0),
                                          Text("Your delivery,",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text("#${orders[index].id},",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          Text("is on the way",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          const SizedBox(height: 10.0),
                                          Text("\$${orders[index].price}",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700)),
                                        ],
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Image.network(
                                            orders[index].imageUrl,
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
                    );
                  },
                ));
  }
}

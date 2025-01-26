import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Order {
  String id;
  String name;
  int price;
  String imageUrl;
  String status;

  Order({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.status,
  });

  factory Order.fromJson(Map<dynamic, dynamic> json) {
    return Order(
      id: json['\$id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
      status: json['status'],
    );
  }
}

class FoodTrackerService {
  static final String _endPoint = dotenv.get("APPWRITE_ENDPOINT");
  static final String _projectId = dotenv.get("APPWRITE_PROJECT_ID");
  static final String _databaseId = dotenv.get("APPWRITE_DATABASE_ID");
  static final String _collectionId = dotenv.get("APPWRITE_COLLECTION_ID");

  final Client client = Client();
  late Databases _database;

  FoodTrackerService() {
    _init();
  }

  //initialize the Appwrite client
  _init() async {
    client.setEndpoint(_endPoint).setProject(_projectId);
    _database = Databases(client);

    //get current session
    Account account = Account(client);

    try {
      await account.get();
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        account
            .createAnonymousSession()
            .then((value) => value)
            .catchError((e) => e);
      }
    }
  }

  Future<List<Order>> getFoodTracker() async {
    List<Order> foodTrackerList = [];
    try {
      final response = await _database.listDocuments(
        databaseId: _databaseId,
        collectionId: _collectionId,
      );
      foodTrackerList = response.documents
          .map<Order>((json) => Order.fromJson(json.data))
          .toList();
    } catch (e) {
      print(e);
    }
    return foodTrackerList;
  }
}

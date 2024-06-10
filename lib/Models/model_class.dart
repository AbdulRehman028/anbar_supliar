class Orders {
  final int number;
  final String title;
  final String location;
  final int quantity;
  final String clientName;
  final String contactNumber;
  final String date;
  final int price;
  final String notes;

  Orders({required this.title, required this.location, required this.quantity, required this.number, required this.clientName, required this.contactNumber, required this.date, required this.price, required this.notes});
  factory Orders.fromFirestore(Map<String, dynamic> json, String documentId) {
    return Orders(
      number: json['number'] as int,
      title: json['title'] as String,
      location: json['location'] as String,
      quantity: json['quantity'] as int,
      clientName: json['clientName'] as String,
      contactNumber: json['contactNumber'] as String,
      date: json['date'] as String,
      price: json['price'] as int,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'location': location,
      'quantity': quantity,
    };
  }
}

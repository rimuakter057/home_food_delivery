import 'request_models.dart';

class RequestMockData {
  RequestMockData._();

  static const List<OrderRequestModel> requests = [
    OrderRequestModel(
      id: 'req_1',
      customerName: 'Alice Brown',
      storeName: 'Fresh Market',
      total: 54.20,
      propertyName: 'Downtown Loft',
      propertyAddress: '123 Main St, Apt 4B, Cityville',
      requestedDate: 'June 12, 2026',
      requestedWindow: '9:00 AM - 10:00 AM',
      status: RequestStatus.pending,
      items: [
        OrderItemModel(quantity: 1, name: 'Organic Bananas', price: 4.99),
        OrderItemModel(quantity: 2, name: 'Whole Milk 1 Gal', price: 7.00),
        OrderItemModel(quantity: 1, name: 'Sourdough Bread', price: 5.99),
        OrderItemModel(quantity: 1, name: 'Free Range Eggs 12ct', price: 6.49),
      ],
    ),
    OrderRequestModel(
      id: 'req_2',
      customerName: 'Mark Wilson',
      storeName: 'City Supermart',
      total: 32.50,
      propertyName: 'Downtown Loft',
      propertyAddress: '123 Main St, Apt 4B, Cityville',
      requestedDate: 'June 12, 2026',
      requestedWindow: '9:00 AM - 10:00 AM',
      status: RequestStatus.pending,
      items: [
        OrderItemModel(quantity: 1, name: 'Organic Bananas', price: 4.99),
        OrderItemModel(quantity: 2, name: 'Whole Milk 1 Gal', price: 7.00),
      ],
    ),
    OrderRequestModel(
      id: 'req_3',
      customerName: 'Mark Wilson',
      storeName: 'City Supermart',
      total: 32.50,
      propertyName: 'Downtown Loft',
      propertyAddress: '123 Main St, Apt 4B, Cityville',
      requestedDate: 'June 12, 2026',
      requestedWindow: '9:00 AM - 10:00 AM',
      status: RequestStatus.pending,
      items: [
        OrderItemModel(quantity: 1, name: 'Organic Bananas', price: 4.99),
        OrderItemModel(quantity: 2, name: 'Whole Milk 1 Gal', price: 7.00),
      ],
    ),
    OrderRequestModel(
      id: 'req_4',
      customerName: 'Alice Brown',
      storeName: 'Fresh Market',
      total: 54.20,
      propertyName: 'Downtown Loft',
      propertyAddress: '123 Main St, Apt 4B, Cityville',
      requestedDate: 'June 12, 2026',
      requestedWindow: '9:00 AM - 10:00 AM',
      status: RequestStatus.scheduled,
      items: [OrderItemModel(quantity: 1, name: 'Organic Bananas', price: 4.99)],
    ),
    OrderRequestModel(
      id: 'req_5',
      customerName: 'Alice Brown',
      storeName: 'Fresh Market',
      total: 34.20,
      propertyName: 'Downtown Loft',
      propertyAddress: '123 Main St, Apt 4B, Cityville',
      requestedDate: 'June 12, 2026',
      requestedWindow: '9:00 AM - 10:00 AM',
      status: RequestStatus.scheduled,
      items: [OrderItemModel(quantity: 1, name: 'Organic Bananas', price: 4.99)],
    ),
    OrderRequestModel(
      id: 'req_6',
      customerName: 'Alice Brown',
      storeName: 'Fresh Market',
      total: 54.20,
      propertyName: 'Downtown Loft',
      propertyAddress: '123 Main St, Apt 4B, Cityville',
      requestedDate: 'June 11, 2026',
      requestedWindow: '9:00 AM - 10:00 AM',
      status: RequestStatus.delivered,
      items: [OrderItemModel(quantity: 1, name: 'Organic Bananas', price: 4.99)],
    ),
    OrderRequestModel(
      id: 'req_7',
      customerName: 'Alice Brown',
      storeName: 'Fresh Market',
      total: 34.28,
      propertyName: 'Downtown Loft',
      propertyAddress: '123 Main St, Apt 4B, Cityville',
      requestedDate: 'June 11, 2026',
      requestedWindow: '9:00 AM - 10:00 AM',
      status: RequestStatus.delivered,
      items: [OrderItemModel(quantity: 1, name: 'Organic Bananas', price: 4.99)],
    ),
  ];

  static OrderRequestModel byId(String id) => requests.firstWhere((r) => r.id == id);

  static List<OrderRequestModel> byStatus(RequestStatus status) => requests.where((r) => r.status == status).toList();
}

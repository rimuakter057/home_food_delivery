import '../../../../core/constants/app_assets.dart';
import 'property_models.dart';

class PropertyMockData {
  PropertyMockData._();

  static const List<PropertyModel> properties = [
    PropertyModel(
      id: 'prop_1',
      name: 'Downtown Loft',
      type: 'Apartment',
      address: '123 Main St, Apt 4B, Cityville',
      code: 'PHX2847',
      activeDeliveries: 2,
      image: AppAssets.propertyDowntownLoft,
      guestStayDuration: 'June 10 - June 15',
      deliveryWindow: '8:00 AM - 10:00 AM',
      recentOrders: [
        RecentOrderModel(customerName: 'John Doe', orderId: '#ORD-1023', date: 'June 12', isApproved: true),
        RecentOrderModel(customerName: 'Jane Smith', orderId: '#ORD-1023', date: 'June 12', isApproved: false),
      ],
    ),
    PropertyModel(
      id: 'prop_2',
      name: 'Sunset Villa',
      type: 'Vacation Rental',
      address: '123 Main St, Apt 4B, Cityville',
      code: 'SUN9921',
      activeDeliveries: 2,
      image: AppAssets.propertySunsetVilla,
      guestStayDuration: 'June 10 - June 15',
      deliveryWindow: '8:00 AM - 10:00 AM',
      recentOrders: [
        RecentOrderModel(customerName: 'John Doe', orderId: '#ORD-1023', date: 'June 12', isApproved: true),
        RecentOrderModel(customerName: 'Jane Smith', orderId: '#ORD-1023', date: 'June 12', isApproved: false),
      ],
    ),
    PropertyModel(
      id: 'prop_3',
      name: 'Cozy Cabin',
      type: 'House',
      address: '123 Main St, Apt 4B, Cityville',
      code: 'CZY4412',
      activeDeliveries: 2,
      image: AppAssets.propertyCozyCabin,
      guestStayDuration: 'June 10 - June 15',
      deliveryWindow: '8:00 AM - 10:00 AM',
      recentOrders: [
        RecentOrderModel(customerName: 'John Doe', orderId: '#ORD-1023', date: 'June 12', isApproved: true),
        RecentOrderModel(customerName: 'Jane Smith', orderId: '#ORD-1023', date: 'June 12', isApproved: false),
      ],
    ),
  ];

  static PropertyModel byId(String id) => properties.firstWhere((p) => p.id == id);
}

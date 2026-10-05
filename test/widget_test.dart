import 'package:flutter_test/flutter_test.dart';
import 'package:bike_consultancy_app/main.dart';

void main() {
  testWidgets('app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const BikeConsultancyApp());

    expect(find.text('Bikes & Easy Finance'), findsOneWidget);
    expect(find.text('Sell Your Bike'), findsOneWidget);
  });
}

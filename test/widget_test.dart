import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:voguegen/screens/homescreen.dart';
import 'package:voguegen/screens/pexels_service.dart';

// Mock classes
class MockImagePicker extends Mock implements ImagePicker {}

class MockPexelsService extends Mock implements PexelsService {}

class MockXFile extends Mock implements XFile {}

void main() {
  group('HomeScreen Tests', () {
    // Mock the dependencies
    final mockImagePicker = MockImagePicker();
    final mockPexelsService = MockPexelsService();

    Widget createTestWidget() => MaterialApp(
          home: Provider<ImagePicker>.value(
            value: mockImagePicker,
            child: Provider<PexelsService>.value(
              value: mockPexelsService,
              child: HomeScreen(),
            ),
          ),
        );

    testWidgets('Clicking "Pick Image" opens image picker',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      // Simulate the image picker returning a mock image
      final mockImage = MockXFile();
      when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => mockImage);

      // Find and tap the 'Pick Image' button
      final pickImageButton = find.widgetWithText(ElevatedButton, 'Pick Image');
      await tester.tap(pickImageButton);
      await tester.pump(); // Rebuild the widget with the new state

      // Verify the image picker was called
      verify(mockImagePicker.pickImage(source: ImageSource.gallery)).called(1);
    });

    testWidgets('Clicking "Generate Styles" triggers image search',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Type into the text field
      await tester.enterText(find.byType(TextField), 'test');

      // Mock the Pexels service response
      when(mockPexelsService.searchImages(argThat(isNotNull, named: 'query')))
          .thenAnswer((_) async => ['https://example.com/image.jpg']);

      // Find and tap the 'Generate Styles' button
      final generateStylesButton =
          find.widgetWithText(ElevatedButton, 'Generate Styles');
      await tester.tap(generateStylesButton);
      await tester.pump(); // Allow time for the state to update

      // Verify the Pexels service was called with a non-null argument
      verify(mockPexelsService.searchImages(argThat(isNotNull, named: 'query')))
          .called(1);
    });
  });
}

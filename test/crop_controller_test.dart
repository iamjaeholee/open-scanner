import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:open_scanner/crop_controller.dart';

void main() {
  test(
    'CropControllerTest initializes 4 default corners based on image size',
    () {
      final controller = CropController(imageWidth: 500, imageHeight: 800);
      final corners = controller.corners;
      final [tl, tr, br, bl] = corners;
      expect(corners.length, 4);
      expect(tl, (50.0, 80.0));
      expect(tr, (450.0, 80.0));
      expect(br, (450.0, 720.0));
      expect(bl, (50.0, 720.0));
    },
  );
}

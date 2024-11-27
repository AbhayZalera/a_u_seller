import 'package:a_u_seller/views/widgets/text_style.dart';
import '../../const/const.dart';

Widget ourButton({required String title, Color color = purpleColor, VoidCallback? onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: color, // Use backgroundColor instead of primary
      padding: const EdgeInsets.all(12.0),
    ),
    onPressed: onPress,
    child: boldText(text: title, size: 16.0),
  );
}

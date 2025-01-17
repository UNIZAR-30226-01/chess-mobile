/// Popup to select spectator options when joining the game.
import 'package:flutter/material.dart';
import '../../visual/screen_size.dart';
import '../../communications/socket_io.dart';
import '../../buttons/home/textfield.dart';
import '../../buttons/home/play.dart';

class Spectator {
  final TextEditingController roomController = TextEditingController();

  void _handleTapSPECTATOR(BuildContext context) async {
    Arguments arguments = Arguments.forSPECTATOR(roomController.text);
    await startGame(context, "SPECTATOR", arguments);
  }

  Object popupSPECTATOR(BuildContext context) {
    roomController.text = "";
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            textField(context, roomController),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Observar", () => _handleTapSPECTATOR(context)),
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class GameMaterial extends StatefulWidget {
  final Widget child;

  const GameMaterial({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _GameMaterialState createState() => _GameMaterialState();

  static ui.Image getMaterial(BuildContext context) {
    final state = context.findAncestorStateOfType<_GameMaterialState>();
    assert(state != null, "The GameMaterial widget was not found");
    return state!.material!;
  }
}

class _GameMaterialState extends State<GameMaterial> {
  /// The image data of /assets/material.png
  ui.Image? material;

  @override
  void initState() {
    super.initState();
    _doLoadMaterial();
  }

  void _doLoadMaterial() async {
    if (material != null) {
      return;
    }
    final bytes = await rootBundle.load("assets/material.png");
    final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      material = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return material == null ? Container() : widget.child;
  }
}

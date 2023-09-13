import 'package:admin/module/dashboard/widgets/hashtag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';

class SecurityOfficeWordCloudExample extends StatelessWidget {
  SecurityOfficeWordCloudExample(this.kFlutterHashtags);

  final List kFlutterHashtags;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < kFlutterHashtags.length; i++) {
      widgets.add(ScatterItem(kFlutterHashtags[i], i));
    }

    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Scatter(
          fillGaps: true,
          delegate: ArchimedeanSpiralScatterDelegate(ratio: ratio),
          children: widgets,
        ),
      ),
    );
  }
}

class ScatterItem extends StatelessWidget {
  ScatterItem(this.hashtag, this.index);
  final FlutterHashtag hashtag;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: hashtag.size.toDouble(),
          color: hashtag.color,
        );
    return RotatedBox(
      quarterTurns: hashtag.rotated ? 1 : 0,
      child: Flexible(
        child: Text(
          hashtag.hashtag,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: style,
        ),
      ),
    );
  }
}

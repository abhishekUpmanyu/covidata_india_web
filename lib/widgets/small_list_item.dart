import 'package:flutter/material.dart';

class SmallListItem extends StatelessWidget {
  final String title;
  final String confirmed;
  final String active;
  final String recovered;
  final String deceased;
  final Color color;
  final VoidCallback onTap;

  const SmallListItem(
      {Key key,
      this.title,
      this.confirmed,
      this.active,
      this.recovered,
      this.deceased,
      this.color,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        color: color ?? Theme.of(context).cardColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text(title)),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(confirmed),
                        Text(active),
                        Text(recovered),
                        Text(deceased),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

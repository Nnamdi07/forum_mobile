import 'package:flutter/material.dart';

class PostData extends StatelessWidget {
  const PostData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Nnamdi  Ijeomah"),
        Text("nnamdi@gmail.com"),
        SizedBox(
          height: 10,
        ),
        Text("Random text"),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.thumb_up),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.comment),
            )
          ],
        ),
      ]),
    );
  }
}

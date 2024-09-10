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
        Text(
          "nnamdi@gmail.com",
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
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

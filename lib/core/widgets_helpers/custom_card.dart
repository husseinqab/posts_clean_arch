import 'package:flutter/material.dart';
import 'package:posts_clean_arch/core/widgets_helpers/circular_image.dart';

import '../constants/radius_constants.dart';

class CustomizedCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final String type;
  // final Color backgroundColor;
  final String? imageUrl;
  final VoidCallback? onAction;
  final double cardRadius;

  const CustomizedCard(
      {Key? key,
      this.body = "N/A",
      this.title = "N/A",
      this.date = "N/A",
      this.type = "..",
      this.onAction,
      // this.backgroundColor = Colors.white,
      this.cardRadius = RadiusConstants.cardRadius,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageUrl == null
                ? const SizedBox()
                : CurvedImage(imageUrl: imageUrl),
            const SizedBox(width: 16),
            SizedBox(
              width: imageUrl == null
                  ? (MediaQuery.of(context).size.width - 140)
                  : MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    maxLines: 10,
                    style: Theme.of(context).textTheme.bodyText1,
                    // style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: KDarkColors.kPrimaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    body,
                    maxLines: 10,
                    style: Theme.of(context).textTheme.bodyText2,
                    // style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // GestureDetector(
                  //   onTap: onAction,
                  //   child: const Text(
                  //     "Do some Action",
                  //     style: TextStyle(color: Colors.blue, fontSize: 13),
                  //   ),
                  // ),
                  /*Row(
                    children: [
                      SizedBox(height:24,width:60,child: ElevatedButton(onPressed: (){}, child: Text("Yes"))),
                      SizedBox(width: 8),
                      SizedBox(height:24,width:60,child:ElevatedButton(onPressed: (){}, child: Text("No"))),
                    ],
                  ),*/
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        type,
                        style: Theme.of(context).textTheme.subtitle1,
                        // style:
                        //     const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "|",
                        style: Theme.of(context).textTheme.subtitle1,
                        // style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.subtitle2,
                        // style:
                        //     const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                splashRadius: 20,
                onPressed: onAction,
                icon: const Icon(Icons.more_vert))
          ],
        ),
      ),
    );
  }
}

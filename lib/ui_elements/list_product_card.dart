
import 'package:flutter/material.dart';

import '../app_config.dart';
import '../my_theme.dart';
import '../screens/product_details.dart';


class ListProductCard extends StatefulWidget {
  int? id;
  String? image;
  String? name;
  String? price;

  ListProductCard({Key? key, this.id, this.image, this.name, this.price})
      : super(key: key);

  @override
  _ListProductCardState createState() => _ListProductCardState();
}

class _ListProductCardState extends State<ListProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(
            id: widget.id!,
          );
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: MyTheme.light_grey, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(16), right: Radius.zero),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: AppConfig.BASE_PATH + widget.image!,
                    fit: BoxFit.cover,
                  ))),
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Text(
                    widget.name!,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Text(
                    widget.price!,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyTheme.accent_color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

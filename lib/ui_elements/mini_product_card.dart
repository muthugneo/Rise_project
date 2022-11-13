import 'package:flutter/material.dart';

import '../app_config.dart';
import '../my_theme.dart';
import '../screens/product_details.dart';


class MiniProductCard extends StatefulWidget {
  int? id;
  String? image;
  String? name;
  String? price;

  MiniProductCard({Key? key, this.id, this.image, this.name, this.price})
      : super(key: key);

  @override
  _MiniProductCardState createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(id: widget.id!);
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: MyTheme.light_grey, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.width - 36) / 3.5,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.zero),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH + widget.image!,
                        fit: BoxFit.cover,
                      ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: Text(
                  widget.name!,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 11,
                      height: 1.6,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Text(
                  widget.price!,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: MyTheme.accent_color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ]),
      ),
    );
  }
}

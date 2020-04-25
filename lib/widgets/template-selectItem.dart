import 'package:flutter/material.dart';


class TemplateSelectItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  

  TemplateSelectItem(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
     });

 
 

  // void _forwardToMealDetail(BuildContext ctx) {
  //   Navigator.of(ctx).pushNamed('/meal-detail', arguments: id);
  // }

  @override
  Widget build(BuildContext context) {
    return  InkWell(
          onTap: () {
           
          },
          highlightColor: Colors.deepOrange,
          child: Container(
              child: Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.asset(
                              imageUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                         
                        ],
                      ),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                         
                          Container(
                            child: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(
                                  Icons.launch,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  title,
                                  style: Theme.of(context).textTheme.subtitle,
                                )),
                          ),
                          
                        ],
                      )
                    ],
                  ))),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hc_meme_generator/widgets/app_drawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme/colors/light_colors.dart';
import 'package:hc_meme_generator/widgets/template-selectItem.dart';
import '../dummy_data.dart';

class TemplateSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var argRoute =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final String argId = argRoute['id'];
    // final String argtitle = argRoute['title'];

    // final filterMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(argId);
    // }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("High Court Meme Generator"),
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MediaQuery.of(context).orientation != Orientation.landscape ?  Container(
            color: Theme.of(context).accentColor,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    radius: 90.0,
                    lineWidth: 5.0,
                    animation: true,
                    percent: 1,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.red,
                    backgroundColor: LightColors.kDarkYellow,
                    center: CircleAvatar(
                      backgroundColor: LightColors.kBlue,
                      radius: 36.0,
                      backgroundImage: AssetImage(
                        'assets/images/avatar2.jpeg',
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'NIT JSR HIGH COURT',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: LightColors.kDarkBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Meme Generator',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ) : Container(),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Select Meme Template",
                  style: Theme.of(context).textTheme.title,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 15,
                        childAspectRatio: 2.8 / 2,
                        mainAxisSpacing: 10,
                        
                        maxCrossAxisExtent: 500,
                      ),
                      itemBuilder: (ctx, index) {
                        return TemplateSelectItem(
                          id: DUMMY_CATEGORIES[index].id,
                          title: DUMMY_CATEGORIES[index].title,
                          imageUrl: DUMMY_CATEGORIES[index].url,
                        );
                      },
                      itemCount: DUMMY_CATEGORIES.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

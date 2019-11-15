import 'package:blog_flutter/routes/navigatorUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/model.dart';
import 'package:flutter_effects/flutter_text_effect.dart';
const sentences = [
    "What is design?",
    "Design is not just",
    "what it looks like and feels like.",
    "Design is how it works. \n- Steve Jobs",
    "Older people",
    "sit down and ask,",
    "'What is it?'",
    "but the boy asks,",
    "What can I do with it?. \n- Steve Jobs",
    "Swift",
    "Objective-C",
    "iPhone",
    "iPad",
    "Mac Mini",
    "MacBook Pro",
    "Mac Pro",
    "爱老婆",
    "老婆和女儿"
  ];
class SearchScreen extends StatefulWidget {
	@override
	_SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Search'),
        backgroundColor: Colors.black,
        elevation: 0.0,
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.search),
						onPressed: () {
							print('开始搜索');
							showSearch(context: context, delegate:SearchBarDelegate());
						},
					)
				],
			),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Center(
              child: LineBorderText(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Search to Page",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                autoAnim: true
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Center(
              child: LineBorderText(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Search to Page",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                autoAnim: true
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Center(
              child: LineBorderText(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Search to Page",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                autoAnim: true
              ),
            ),
          )
        ],
      )
		);
	}
}

class SearchBarDelegate extends SearchDelegate<String>{
	@override
	List<Widget> buildActions(BuildContext context) { // 重写buildActions，目的是为了在搜索条右侧放入一个清除图标，点击图片清除内容
		return [
			IconButton(
				icon: Icon(Icons.clear),
				onPressed: () => query = ''
			)
		];
	}
	@override
	Widget buildLeading(BuildContext context) { // 重写buildLeading，目的是为了点击关闭整个搜索页面
		return 	IconButton(
			icon: AnimatedIcon(
				icon: AnimatedIcons.menu_arrow,
				progress: transitionAnimation,
			),
			onPressed: () => close(context, null),
		);
	}
	@override
	Widget buildResults(BuildContext context) { // 重写buildResults【搜到的内容展示】
		return Container(
			width: 100.0,
			height: 100.0,
			child: Card(
				color: Colors.redAccent,
				child: Center(
					child: Text(query),
				),
			),
		);
	}
	@override
	Widget buildSuggestions(BuildContext context) { //重写buildSuggestions【设置推荐】
  var activelist = Provider.of<CounterNotifier>(context).activelist;
		dynamic suggestionList = query.isEmpty ? activelist : activelist.where((input) => input['title'].contains(query)).toList();
    print(suggestionList);
    List<Widget> view = List();

    for(var i = 0; i < suggestionList.length; i++) {
      view
        ..add(
          InkResponse(
            highlightShape: BoxShape.rectangle,
            radius: 300.0,
            splashColor: Color(0xFFDCDCDC),
            containedInkWell: true,
            onTap: (){
              Histroy().push(
                context: context,
                path: '/detail?id=${suggestionList[i]['activeid']}',
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              // color: Colors.red,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    // child: Text(
                    //   suggestionList[i]['title'],
                    //   style: TextStyle(
                    //     fontSize: 17.0,
                        
                    //   ),
                    // ),
                    child: RichText(
                      text: TextSpan(
                        text: suggestionList[i]['title'].substring(0, query.length),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: suggestionList[i]['title'].substring(query.length),
                            style: TextStyle(color: Colors.grey)
                          )
                        ]
                      ),
                    ),
                  )
                ],
              )
            ),
          )
        );
    }
    return ListView(
      children: view,
    );
		// return ListView.builder(
		// 	itemCount: suggestionList.length,
		// 	itemBuilder: (context, index) => ListTile(
				// title: 
		// 	),
		// );
  }
}

import 'package:blog_flutter/routes/navigatorUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../model/model.dart';
// import 'package:flutter_effects/flutter_text_effect.dart';
import '../../widgets/Diffscaletext/diff_scale_text.dart';

const sentencess = [
  '所有漂亮的结果都是在行动中',
  '收获的你不需要很厉害才能开始',
  '但你需要开始才能变得很厉害',
  '_____________________________',
  '我越来越相信',
  '创造美好的代价是',
  '努力、失望以及毅力',
  '首先是疼痛',
  '然后才是欢乐。——梵高',
  '_____________________________',
  '敢于面对困境的人',
  '生命因此坚强',
  '敢于挑战逆境的人',
  '生命因此茁壮',
  '_____________________________',
  '努力的最大动力',
  '在于你可以选择你想要的生活',
  '而不是被生活选择',
  '弱者只有千难万难',
  '而勇者则能披荆斩棘',
  '愚者只有声声哀叹',
  '智者却有千路万路',
  '_____________________________',
];
class SearchScreen extends StatefulWidget {
	@override
	_SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int diffScaleNext = 0;
  Timer countdownTimer;
  countdown(){
    Timer countdownTimer =  new Timer.periodic(new Duration(seconds: 2), (timer) {
        setState(() {
          diffScaleNext++;
        });
    });
  }
  @override
  void initState() {
    countdown();
    super.initState();
  }
  @override
  void dispose() {
    countdownTimer?.cancel();
    countdownTimer = null;
    super.dispose();
  }
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
            color: Colors.black,
            child: InkResponse(
              child: Center(
                child: DiffScaleText(
                  text: sentencess[diffScaleNext % sentencess.length],
                  textStyle: TextStyle(
                    fontSize: 17.0, 
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: (){
                
              },
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

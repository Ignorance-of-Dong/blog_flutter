import 'package:blog_flutter/routes/navigatorUtil.dart';
import 'package:blog_flutter/widgets/Drawer/drawer_slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/model.dart';
import 'dart:async';
import 'package:jpush_flutter/jpush_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
  }): super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return HomeScreens(context: context);
  }
}

class HomeScreens extends StatefulWidget {
  final context;
  HomeScreens({
    Key key,
    @required this.context,
  }):super(key: key);
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  BuildContext context;
  Timer countdownTimer;
  final JPush _jPush = JPush();
  Future<void> initPlatformState() async {
    _jPush.setup(
      appKey: "c2704897bea615d384035c30",
      channel: "flutter_channel",
      production: false,
      debug: true,
    );
    if (!mounted) return;
  }
  @override
  void initState() {
    this.context = widget.context;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<CounterNotifier>(context).getActiveList(context);
    });
    super.initState();
    initPlatformState();
    String n = new DateTime.now().toString().split(' ')[0];
    Timer countdownTimer =  new Timer.periodic(new Duration(seconds: 1), (timer) {
      String nowDate = new DateTime.now().toString().split('.')[0];
      if (nowDate == (n + ' ' + '9:00:00')) {
        timingpush('早上好，元气满满！！');
      }
      if (nowDate == (n + ' ' + '12:00:00')) {
        timingpush('中午好，准备吃饭了！！');
      }
      if (nowDate == (n + ' ' + '18:00:00')) {
        timingpush('晚上好，休息一下，褪去一天的风尘！！');
      }
    });
    
  }
  @override
  void dispose() {
    countdownTimer?.cancel();
    countdownTimer = null;
    super.dispose();
  }
  void timingpush(context){
    var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3000);
    var localNotification = LocalNotification(
      id: 000001,
      title: 'Oil bottle',
      buildId: 1,
      content: context,
      fireTime: fireDate,
      extra: {"extra_key": "extra_value"});
      _jPush.sendLocalNotification(localNotification).then((res) {
        // setState(() {
        //   _result = res;
        // });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 10.0,
      	onPressed: () {
      		// Navigator.of(context).push(CustomeRoute(SearchScreen()));
          Histroy().push(
            context: context,
            path: '/search',
          );
      	},
      	tooltip: 'search',
      	child: Icon(
      		Icons.search,
      		color: Colors.white,
      	),
      ),
      appBar: AppBar(
        title: Text('倥侗无知'),
        backgroundColor: Colors.black,
      ),
      drawer: CustomDrawer(
        widthPercent: 0.85,
        child:Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              //Material内置控件
              accountName: new Text(
                '想上树的跳蚤',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ), //用户名
              accountEmail: new Text(
                '',
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              currentAccountPicture: new GestureDetector(
                //用户头像
                onTap: () => print('current user'),
                child: new CircleAvatar(
                  //圆形图标控件
                  backgroundImage: new NetworkImage(
                      'http://p2.music.126.net/SHElx36maw8L6CIXfiNbFw==/109951164144982394.jpg'),
                ),
              ),
              decoration: new BoxDecoration(
                //用一个BoxDecoration装饰器提供背景图片
                // image: new DecorationImage(
                //     fit: BoxFit.fill,
                //     image: new NetworkImage(
                //         'https://p1.music.126.net/SQqdcP9ky0303j-GVcIQjw==/109951164215953688.jpg')),
                color: Colors.white
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              // color: Colors.red,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Center(
                child: Text(
                  '如果可以一个人待在房间里数个小时沉浸在一些真正有趣的问题上，那将会是最开心的时光。'
                ),
              ),
            ),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80.0,
              // color: Colors.yellow,
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.,/
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.white,
                    child: Icon(
                      Icons.all_out,
                      size: 40.0,
                    ),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      size: 40.0,
                    ),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.white,
                    child: Icon(
                      Icons.offline_bolt,
                      size: 40.0,
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              // color: Colors.red,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Center(
                child: InkResponse(
                  child: Text(
                  '系统由👉Flutter提供！！！'
                  ),
                  onTap: (){
                    // timingpush();
                  },
                )
              ),
            ),
          ],
        )
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: listColumnView(context)
              ),
            ),
          )
        ],
      )
    );
  }
  List<Widget> listColumnView(BuildContext context){
    var activelist = Provider.of<CounterNotifier>(context).activelist;
    List<Widget> view = List();
    for(var i = 0; i < activelist.length; i++){
      view
        ..add(
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            height: 250.0,
            // color: Colors.red,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  // color: Colors.blue,
                  child: Center(
                    child: Text(
                      activelist[i]['title'],
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  // color: Colors.yellow,
                  child: Center(
                    child: Text(
                      'Posted on ${activelist[i]['uploadate']}',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey
                      ),
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.white,
                    child: Center(
                      child: Text(
                        activelist[i]['introduction'],
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  margin: EdgeInsets.only(top: 10.0),
                  // color: Colors.yellow,
                  child: InkResponse(
                    onTap: (){
                      Histroy().push(
                        context: context,
                        path: '/detail?id=${activelist[i]['activeid']}',
                      );
                    },
                    child: Center(
                      child: Container(
                        width: 200.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          border: new Border.all(width: 2.0, color: Colors.black),
                        ),
                        child: Center(
                            
                            child: Text(
                              'Read more »',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey
                              ),
                            ),
                        ),
                      ),
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Divider(),
                )
              ],
            ),
          ),
        );
    }
    return view;
  }
}

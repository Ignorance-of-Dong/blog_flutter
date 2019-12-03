import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import '../../model/model.dart';
var markdown='# 文章过大无法解析【能力有限】\n' +
  '``` var a=11; ```';


class DetailScreen extends StatefulWidget {
  final id;
  DetailScreen({
    Key key,
    @required this.id,
  }):super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String id = '';

  @override
  void initState() {
    this.id = widget.id ?? this.id;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DetailScreens(context: context, id: id);
  }
}
class DetailScreens extends StatefulWidget {
  final id;
  final context;
  DetailScreens({
    Key key,
    @required this.id,
    @required this.context,
  }):super(key:key);
  @override
  _DetailScreensState createState() => _DetailScreensState();
}

class _DetailScreensState extends State<DetailScreens> {
  String id = '';
  BuildContext context;
  @override
  void initState() {
    this.id = widget.id ?? this.id;
    this.context = widget.context ?? this.context;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      var params = {
        'id': id
      };
      Provider.of<CounterNotifier>(context).getActiveDetail(context, params);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var activeDetails = Provider.of<CounterNotifier>(context).activeDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text(activeDetails['title'] ?? '文章详情'),
        backgroundColor: Colors.black,
      ),
      body: Markdown(data: activeDetails['activeContent'] ?? markdown)
    );
  }
}
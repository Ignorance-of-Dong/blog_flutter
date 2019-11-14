import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import '../../model/model.dart';
var markdown='# P01:课程介绍和环境搭建\n' +
  '[ **M** ] arkdown + E [ **ditor** ] = **Mditor**  \n' +
  '> Mditor 是一个简洁、易于集成、方便扩展、期望舒服的编写 markdown 的编辑器，仅此而已... \n\n' +
   '**这是加粗的文字**\n\n' +
  '*这是倾斜的文字*`\n\n' +
  '***这是斜体加粗的文字***\n\n' +
  '~~这是加删除线的文字~~ \n\n'+
  '\`console.log(111)\` \n\n'+
  '# p02:来个Hello World 初始Vue3.0\n' +
  '> aaaaaaaaa\n' +
  '>> bbbbbbbbb\n' +
  '>>> cccccccccc\n'+
  '***\n\n\n' +
  '# p03:Vue3.0基础知识讲解\n' +
  '> aaaaaaaaa\n' +
  '>> bbbbbbbbb\n' +
  '>>> cccccccccc\n\n'+
  '# p04:Vue3.0基础知识讲解\n' +
  '> aaaaaaaaa\n' +
  '>> bbbbbbbbb\n' +
  '>>> cccccccccc\n\n'+
  '#5 p05:Vue3.0基础知识讲解\n' +
  '> aaaaaaaaa\n' +
  '>> bbbbbbbbb\n' +
  '>>> cccccccccc\n\n'+
  '# p06:Vue3.0基础知识讲解\n' +
  '> aaaaaaaaa\n' +
  '>> bbbbbbbbb\n' +
  '>>> cccccccccc\n\n'+
  '# p07:Vue3.0基础知识讲解\n' +
  '> aaaaaaaaa\n' +
  '>> bbbbbbbbb\n' +
  '>>> cccccccccc\n\n'+
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
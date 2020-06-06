import 'package:flutter/material.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:provide/provide.dart';
import '../../provide/search.dart';
import './results_view.dart';

class SearchPage extends SearchDelegate<String> {
  SearchPage({query});

  // buildActions方法是搜索条右侧的按钮执行方法
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
      // IconButton(
      // icon: Icon(Icons.mic),
      // color: Theme.of(context).primaryColor,
      // onPressed: () {
      //   Application.router.navigateTo(context, '/speak');
      // }),
    ];
  }

  // 搜索栏左侧的图标和功能
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  // buildResults方法，是搜到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      Provide.value<SearchProvide>(context).searchGoods(query);
    } else {
      showSuggestions(context);
    }

    return ResultsView();
  }

  // 搜索推荐提示
  @override
  Widget buildSuggestions(BuildContext context) {
    Provide.value<SearchProvide>(context).initsearchWord();
    return Provide<SearchProvide>(builder: (context, child, val) {
      List<String> suggestionsList =
          Provide.value<SearchProvide>(context).searchWordList;
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  '历史记录',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Wrap(
                  spacing: 10,
                  // runSpacing: 0,
                  children: suggestionsList.map((item) {
                    return _suggestionsItem(item);
                  }).toList(),
                ),
              )
            ]),
      );
    });
  }

  // 历史记录项
  Widget _suggestionsItem(word) {
    return Container(
      child: InkWell(
        child: Chip(
          label: Text(word),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () {
          query = word;
        },
      ),
    );
  }
}

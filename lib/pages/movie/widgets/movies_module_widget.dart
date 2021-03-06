import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/movie/bean/movie_resp.dart';
import 'package:flutter_movie/pages/movie/router/movie_router.dart';
import 'package:flutter_movie/res/colors.dart';
import 'package:flutter_movie/res/dimens.dart';
import 'package:flutter_movie/router/fluro_navigator.dart';
import 'package:flutter_movie/utils/adapt_ui.dart';
import 'package:flutter_movie/utils/array_util.dart';
import 'package:flutter_movie/utils/image_utils.dart';

class MoviesModuleWidget extends StatefulWidget {
  final Movies movies;

  const MoviesModuleWidget({Key key, this.movies}) : super(key: key);

  @override
  _MoviesModuleWidgetState createState() => _MoviesModuleWidgetState();
}

class _MoviesModuleWidgetState extends State<MoviesModuleWidget> {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = ArrayUtil.isEmpty(widget.movies?.list);
    return isEmpty
        ? SizedBox()
        : Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      bottom: UIAdaptor.w(5),
                      right: UIAdaptor.w(10),
                      left: UIAdaptor.w(20)),
                  child: Row(
                    children: <Widget>[
                      _titleWidget(widget?.movies?.typeName),
                      Expanded(
                        child: SizedBox(),
                        flex: 1,
                      ),
                      GestureDetector(
                        child: _rightWidget(),
                        onTap: () {
                          //查看更多
                        },
                      )
                    ],
                  ),
                ), //头部标题
                Container(
                  margin: EdgeInsets.only(
                      left: UIAdaptor.w(20), right: UIAdaptor.w(20)),
                  child: _moviesGrid(widget?.movies?.list),
                )              ],
            ),
          );
  }

  ///模块的标题
  Widget _titleWidget(String title) {
    return Text(
      title ?? "",
      style: TextStyle(
          fontSize: FontSize.title,
          fontWeight: FontWeight.normal,
          color: Colours.text_normal),
    );
  }

  ///右边的箭头提示
  Widget _rightWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            '查看更多',
            style: TextStyle(
                fontSize: FontSize.normal, color: Colours.text_gray_6),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: UIAdaptor.w(20)),
          child: Icon(
            Icons.chevron_right,
            color: Colours.text_gray_6,
            textDirection: prefix0.TextDirection.ltr,
            size: UIAdaptor.sp(40),
          ),
        )
      ],
    );
  }

  ///网格显示电影
  Widget _moviesGrid(List<Movie> movieList) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: UIAdaptor.h(20),
          crossAxisSpacing: UIAdaptor.w(20),
          childAspectRatio: 0.6),
      itemBuilder: (context, index) {
        Movie movie = movieList[index];
        return GestureDetector(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _coverWidget(movie),
                ), //封面
                Container(
                  color: Colours.white,
                  child: Text(
                    movie.name ?? '',
                    style: TextStyle(
                        fontSize: FontSize.normal, color: Colours.text_normal),
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ) //电影名称
              ],
            ),
          ),
          onTap: (){
            NavigatorUtils.push(context, MovieRouter.movieDetail, params: Map()..['movieId'] = movie?.id?.toString());
          },
        );
      },
      itemCount: movieList?.length ?? 0,
    );
  }

  ///封面展示
  Widget _coverWidget(Movie movie) {
    return Container(
      color: Colours.list_bg_color,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child:
                  ImageUtil.loadNetworkImage(movie?.cover, fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    movie?.type ?? '',
                    style: TextStyle(
                        color: Colours.color_FF9C29, fontSize: FontSize.normal),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    movie.rank?.toString() ?? '',
                    style: TextStyle(
                        color: Colours.color_FF9C29, fontSize: FontSize.normal),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

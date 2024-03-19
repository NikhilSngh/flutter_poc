import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_size_constants.dart';
import 'package:flutter_poc/data/network/api_url.dart';
import 'package:flutter_poc/helper/responsive_widget.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/theme/sizes.dart';


class CarouselView extends StatefulWidget {
  final List<Movie> movieList;
  const CarouselView(this.movieList, {super.key});

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  int _currentPage = 0;
  int _totalPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _totalPage = widget.movieList.length;
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        if (_currentPage < (_totalPage - 1)) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInSine);
        setState(() { });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size4),
      height: Sizes.size8,
      width: Sizes.size8,
      decoration: BoxDecoration(
        boxShadow: [
          isActive ? const BoxShadow(
            color: Colors.indigo,
            blurRadius: Sizes.size4,
            spreadRadius: 1.0
          ) : const BoxShadow(
            color: Colors.transparent
          )
        ],
        shape: BoxShape.circle,
        color: isActive ? Colors.indigo : const Color(0XFFEAEAEA)
      )
    );
  }

  Widget _buildPageIndicator() {
    return Positioned.fill(
        bottom: 0,
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            height: Sizes.size30,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withAlpha(200),
                      Colors.black.withAlpha(0)]
                )),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.movieList.map((element) {
                  return _indicator(element == widget.movieList[_currentPage]);
                }).toList())
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return LayoutBuilder(
      builder: (context, constraint){
        return SizedBox(
            height: ResponsiveWidget.isSmallScreen(context)? 200:400,
            child: Stack(
                children: [
                  PageView.builder(
                      itemCount: _totalPage,
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: (value) {
                        _currentPage = value;
                        setState(() { });
                        _animationController.forward();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: (){

                            },
                            child: Image.network(
                              ApiUrl.IMAGE_BASE_URL +
                                  widget.movieList[index].backdropPath.toString(),
                              fit: BoxFit.contain,
                              height: Sizes.size200,
                            )
                        );
                      }),
                  _buildPageIndicator()
                ])
        );
      },

    );
  }
}
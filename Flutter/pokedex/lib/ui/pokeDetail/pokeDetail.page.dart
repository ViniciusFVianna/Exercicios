import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/conts/contsApp.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokiapi_store.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;

  PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  PageController _pageController;
  Pokemon _pokemon;
  PokeAPIStore _pokemonStore;
  MultiTrackTween _animation;
  double _progress;
  double _multiple;
  double _opacity;
  double _opacityTitleAppBar;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonStore = GetIt.instance<PokeAPIStore>();
    _pokemon = _pokemonStore.pokemonAtual;

    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);

    _progress = 0;
    _multiple = 1;
    _opacity = 1;
    _opacityTitleAppBar = 0;
  }

  double inerval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress - lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (context) {
            return AppBar(
              title: Opacity(
                opacity: _opacityTitleAppBar,
                child: Text(
                  _pokemonStore.pokemonAtual.name,
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: _pokemonStore.corPokemon,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ControlledAnimation(
                        playback: Playback.LOOP,
                        duration: _animation.duration,
                        tween: _animation,
                        builder: (context, animation) {
                          return Transform.rotate(
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 200),
                              child: Image.asset(
                                ConstsApp.whitePokeball,
                                height: 50,
                                width: 50,
                              ),
                              opacity: _opacityTitleAppBar >= 0.2 ? 0.2 : 0.0,
                            ),
                            angle: animation['rotation'],
                          );
                        }),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return Container(
                color: _pokemonStore.corPokemon,
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
            listener: (state) {
              setState(() {
                _progress = state.progress;
                _multiple = 1 - inerval(0.0, 0.7, _progress);
                _opacity = _multiple;
                _opacityTitleAppBar = _multiple = inerval(0.0, 0.7, _progress);
              });
            },
          ),
          Opacity(
            opacity: _opacity,
            child: Padding(
              padding: EdgeInsets.only(top: _opacityTitleAppBar == 1 ? 1000 : 60 - _progress * 60),
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokemonStore.setPokemonAtual(index: index);
                  },
                  itemCount: _pokemonStore.pokeAPI.pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pokemon _pokeItem = _pokemonStore.getPokemon(index: index);
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ControlledAnimation(
                          playback: Playback.LOOP,
                          duration: _animation.duration,
                          tween: _animation,
                          builder: (context, animation) {
                            return Transform.rotate(
                              angle: animation['rotation'],
                              child: Hero(
                                //tag: _pokeItem.name + 'rotation',
                                tag: '',
                                child: Opacity(
                                  opacity: 0.2,
                                  child: Image.asset(
                                    ConstsApp.whitePokeball,
                                    height: 270,
                                    width: 270,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Observer(
                          builder: (context) {
                            return AnimatedPadding(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.bounceInOut,
                              padding: EdgeInsets.all(
                                index == _pokemonStore.posicaoAtual ? 0 : 60,
                              ),
                              child: Hero(
                                tag: _pokeItem.name,
                                child: CachedNetworkImage(
                                  height: 160,
                                  width: 160,
                                  placeholder: (context, url) => new Container(
                                    color: Colors.transparent,
                                  ),
                                  color: index == _pokemonStore.posicaoAtual
                                      ? null
                                      : Colors.black.withOpacity(0.5),
                                  imageUrl:
                                      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

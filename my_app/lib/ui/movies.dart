import 'package:flutter/material.dart';
import 'package:my_app/model/movie.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: <Widget>[
              Positioned(child: movieCard(context, movieList[index])),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0])),
            ]);
          }),
    );
  }

  Widget movieCard(BuildContext context, Movie movie) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
            elevation: 3.0,
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 60, right: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(movie.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0)),
                        ),
                        Text(
                          'IMDB: ${movie.imdbRating}/10',
                          style: mainTextStyle(),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Released: ${movie.released}',
                            style: mainTextStyle()),
                        Text(movie.rated, style: mainTextStyle()),
                        Text(movie.runtime, style: mainTextStyle())
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListViewDetails(
                      movie: movie,
                    )))
      },
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  NetworkImage(imageUrl ?? "https://picsum.photos/200/300"))),
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(color: Colors.blueGrey.shade800, fontSize: 12.0);
  }
}

class MovieListViewDetails extends StatelessWidget {
  final Movie movie;

  const MovieListViewDetails({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView(
        children: <Widget>[
          MovieDetailsThumbnail(
            thumbnail: movie.images[0],
          ),
          MovieDetailsHeaderWithPoster(
            movie: movie,
          ),
          HorizontalLine(),
          MovieDetailsCast(
            movie: movie,
          ),
          HorizontalLine(),
          MovieDetailsExtraPosters(
            posters: movie.images,
          )
        ],
      ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key key, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover)),
            ),
            InkWell(
              onTap: () async {
                if (await canLaunch(
                    'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
                  await launch(
                      'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw');
                } else {
                  throw 'Could not launch';
                }
              },
              child: Icon(
                Icons.play_circle_outline,
                size: 100,
                color: Colors.white,
              ),
            )
          ],
        ),
        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)]),
            ),
            height: 80)
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderWithPoster({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          MoviePoster(
            poster: movie.images[0],
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: MovieDetailsHeader(movie: movie),
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(poster))),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Year: ${movie.year}. ${movie.genre}.".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.cyan.shade600),
        ),
        Text(
          movie.title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28.0),
        ),
        Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(text: movie.plot),
          TextSpan(text: "More..", style: TextStyle(color: Colors.indigoAccent))
        ], style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Awards", value: movie.awards),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$field: ",
          style: TextStyle(
              color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsExtraPosters({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'More movie posters..'.toUpperCase(),
            style: TextStyle(fontSize: 14.0, color: Colors.black26),
          ),
        ),
        Container(
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8.0),
                itemCount: posters.length,
                itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(posters[index]))),
                    ))))
      ],
    );
  }
}

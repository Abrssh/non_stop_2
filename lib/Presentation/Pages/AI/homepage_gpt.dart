import 'package:flutter/material.dart';

void main() {
  runApp(TrendingMusicApp());
}

class TrendingMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrendingMusicScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TrendingMusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171429),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.menu),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white70),
                      SizedBox(width: 8),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Trending right now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200, // Height for horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Number of trending items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TrendingMusicCard(),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            // Genre Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GenreTab(title: 'Trending right now', selected: true),
                GenreTab(title: 'Rock'),
                GenreTab(title: 'Hip Hop'),
                GenreTab(title: 'Electro'),
                GenreTab(title: 'Pop'),
              ],
            ),
            SizedBox(height: 16),
            // Song List
            Expanded(
              child: ListView(
                children: [
                  SongListItem(
                    title: "I'm Good (Blue)",
                    artist: "David Guetta & Bebe Rexha",
                  ),
                  SongListItem(
                    title: "Under the Influence",
                    artist: "Chris Brown",
                  ),
                  SongListItem(
                    title: "Forget Me",
                    artist: "Lewis Capaldi",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 68, 40, 228),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class TrendingMusicCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(
              'https://images.pexels.com/photos/2996262/pexels-photo-2996262.jpeg?auto=compress&cs=tinysrgb&w=600'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 10,
            child: Text(
              'The Dark Side',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              'Muse - Simulation Theory',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Icon(Icons.play_circle_fill, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }
}

class GenreTab extends StatelessWidget {
  final String title;
  final bool selected;

  const GenreTab({required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.blueAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class SongListItem extends StatelessWidget {
  final String title;
  final String artist;

  const SongListItem({required this.title, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.music_note, color: Colors.white),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                artist,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.favorite_border, color: Colors.white),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:musifier/service/song_service.dart';
// import 'package:musifier/widgets/navBar.dart';
// import '../models/songSearch.dart';

// class SongSearchPage extends HookWidget {
//   const SongSearchPage({super.key});
//   final int _currentIndex = 2;

//   @override
//   Widget build(BuildContext context) {
//     final query = useState('');

//     final future =
//         useMemoized(() => SongService().fetchSongs(query.value), [query.value]);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Songs'),
//         backgroundColor: const Color(0xFF1B1B37),
//       ),
//       backgroundColor: const Color(0xFF1B1B37),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Search for a song',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.blue, width: 2),
//                 ),
//                 filled: true,
//                 fillColor: Color(0xFF1B1B37),
//               ),
//               onChanged: (value) => query.value = value,
//             ),
//             const SizedBox(height: 10),
// Expanded(
//   child: FutureBuilder<List<SongSearch>>(
//     future: future,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text('Error: ${snapshot.error}'));
//       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return const Center(child: Text('No songs found'));
//       }

//       final songs = snapshot.data!;
//       return ListView.builder(
//         itemCount: songs.length,
//         itemBuilder: (context, index) {
//           final song = songs[index];
//           return ListTile(
//             leading: song.cover.isNotEmpty
//                 ? Image.network(song.cover,
//                     width: 50, height: 50, fit: BoxFit.cover)
//                 : const Icon(Icons.music_note),
//             title: Text(song.title),
//             subtitle: Text(song.artist),
//           );
//         },
//       );
//     },
//   ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: NavigationWidget(
//         currentIndex: _currentIndex,
//       ),
//     );
//   }
// } id: 131706, createdAt: "2024-10-02T03:01:00.775Z", updatedAt: "2024-10-02T03:01:00.775Z",duration: 219200, externalId: "0cqRj7pUJDkTCEsJkx8snD",id: 32330, image: "https://i.scdn.co/image/ab67616d0000b27352b2a3824413eefe9e33817a", name: "Shake It Off", primaryColor: null,
//
import 'package:flutter/material.dart';
import 'package:musifier/models/song.dart';
import 'package:musifier/pages/MusicPlayerPage.dart';
import 'package:musifier/widgets/navBar.dart';

class SongSearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SongSearchPage> {
  final int _currentIndex = 2;
  List<Map<String, dynamic>> mockData = [
    {
      "id": 131706,
      "artist": "Taylor Swift",
      "createdAt": "2024-10-02T03:01:00.775Z",
      "updatedAt": "2024-10-02T03:01:00.775Z",
      "duration": 219200,
      "externalId": "0cqRj7pUJDkTCEsJkx8snD",
      "image":
          "https://i.scdn.co/image/ab67616d0000b27352b2a3824413eefe9e33817a",
      "name": "Shake It Off",
      "primaryColor": null
    },
    {
      "id": 885,
      "artist": "Rihanna, JAY-Z",
      "createdAt": "2024-10-03T05:15:00.775Z",
      "updatedAt": "2024-10-03T05:15:00.775Z",
      "duration": 275986,
      "externalId": "49FYlytm3dAAraYgpoJZux",
      "image":
          "https://i.scdn.co/image/ab67616d0000b273f9f27162ab1ed45b8d7a7e98",
      "name": "Umbrella",
      "primaryColor": null
    },
    {
      "id": 32331,
      "artist": "Carly Rae Jepsen",
      "createdAt": "2024-10-04T07:25:00.775Z",
      "updatedAt": "2024-10-04T07:25:00.775Z",
      "duration": 193400,
      "externalId": "20I6sIOMTCkB6w7ryavxtO",
      "image":
          "https://i.scdn.co/image/ab67616d0000b273d3ee4bf67c2ac2154006ad72",
      "name": "Call Me Maybe",
      "primaryColor": null
    },
    {
      "id": 32332,
      "artist": "Miley Cyrus",
      "createdAt": "2024-10-04T07:25:00.775Z",
      "updatedAt": "2024-10-04T07:25:00.775Z",
      "duration": 202066,
      "externalId": "5m7T3eJlK0O92QOCT2SpVM",
      "image":
          "https://i.scdn.co/image/ab67616d0000b273068404454353254d4126c2e4",
      "name": "Party In The U.S.A.",
      "primaryColor": null
    },
    {
      "id": 3562,
      "artist": "Beyonce",
      "createdAt": "2024-10-04T07:25:00.775Z",
      "updatedAt": "2024-10-04T07:25:00.775Z",
      "duration": 267413,
      "externalId": "1z6WtY7X4HQJvzxC4UgkSf",
      "image":
          "https://i.scdn.co/image/ab67616d0000b273ff5429125128b43572dbdccd",
      "name": "Love On Top",
      "primaryColor": null
    },
    {
      "id": 32333,
      "artist": "Kelly Clarkson",
      "createdAt": "2024-10-04T07:25:00.775Z",
      "updatedAt": "2024-10-04T07:25:00.775Z",
      "duration": 221946,
      "externalId": "1nInOsHbtotAmEOQhtvnzP",
      "image":
          "https://i.scdn.co/image/ab67616d0000b273af384269742c6b04308c1be8",
      "name": "Stronger (What Doesn't Kill You)",
      "primaryColor": null
    },
    {
      "id": 32334,
      "artist": "Lady Gaga,Colby O'Donis",
      "createdAt": "2024-10-04T07:25:00.775Z",
      "updatedAt": "2024-10-04T07:25:00.775Z",
      "duration": 241933,
      "externalId": "1dzQoRqT5ucxXVaAhTcT0J",
      "image":
          "https://i.scdn.co/image/ab67616d0000b273e691217483df8798445c82e2",
      "name": "Just Dance",
      "primaryColor": null
    }
  ];

  List<Map<String, dynamic>> filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredData = List.from(mockData);
  }

  void filterSearch(String query) {
    List<Map<String, dynamic>> tempList = [];
    if (query.isNotEmpty) {
      tempList = mockData
          .where((item) =>
              item["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      tempList = List.from(mockData);
    }

    setState(() {
      filteredData = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Songs'),
        backgroundColor: const Color(0xFF1B1B37),
      ),
      backgroundColor: const Color(0xFF1B1B37),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              onChanged: filterSearch,
              decoration: InputDecoration(
                labelText: "Search by Name",
                hintText: "Type to search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                var item = filteredData[index];
                return ListTile(
                  leading: Image.network(
                    item["image"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item["name"]),
                  subtitle: Text(item["artist"]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerPage(
                          songId: item["id"],
                          song: Song(
                            id: item["id"],
                            name: item["name"],
                            image: item["image"],
                            artists: item["artist"],
                            duration: item["duration"],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }
}

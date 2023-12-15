import 'package:boardinghouse_app/screens/search/search_results_page.dart';
import 'package:flutter/material.dart';

class SearchBoxPage extends StatefulWidget {
  @override
  _SearchBoxPageState createState() => _SearchBoxPageState();
}

class _SearchBoxPageState extends State<SearchBoxPage> {
  List<String> data = [
    'C',
    'c',
    'city',
    'Cái răng',
    'Ninh kiều',
    'Ninh kiều, Cần Thơ',

    // Add more items as needed
  ];

  List<String> filteredData = [];
  bool noResults = false;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Color.fromRGBO(0, 177, 237, 1),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('main');
          },
        ),
        // automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          onChanged: (value) {
            setState(() {
              filteredData = data
                  .where((item) =>
                      item.toLowerCase().contains(value.toLowerCase()))
                  .toList();
              noResults = filteredData.isEmpty;
              text = value;
            });
          },
          decoration: const InputDecoration(
            // labelText: 'Search',
            hintText: 'Nhập địa chỉ tìm kiếm',
            // prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: noResults
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SearchResultsPage(
                                address: text,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(text),
                          // Add more ListTile customization as needed
                        ),
                      ),
                      const Divider(
                        color: Colors.black38,
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SearchResultsPage(
                                    address: filteredData[index],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(filteredData[index]),
                              // Add more ListTile customization as needed
                            ),
                          ),
                          const Divider(
                            color: Colors.black38,
                          )
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

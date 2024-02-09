import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User List",style: TextStyle(color: Colors.white),),
        leading:const Icon(Icons.arrow_back,color: Colors.white,),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
                label: Text("Search"), suffix: Icon(Icons.search),
                ),
          )
        ],
      ),
    );
  }
}

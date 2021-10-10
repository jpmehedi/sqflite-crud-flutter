import 'package:flutter/material.dart';
import 'package:sqlite/customer_model.dart';
import 'package:sqlite/database_helper.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fNameEditingController = TextEditingController();
  var lNameEditingController = TextEditingController();
  var emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqlite"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                TextField(
                  controller: fNameEditingController,
                  decoration: InputDecoration(
                    hintText: "First Name"
                  ),
                ),
                 TextField(
                  controller: lNameEditingController,
                  decoration: InputDecoration(
                    hintText: "Last Name"
                  ),
                ),
               TextField(
                  controller: emailEditingController,
                  decoration: InputDecoration(
                    hintText: "Email"
                  ),
                ),


                ElevatedButton(          
                  onPressed:() async{
                    final customer = CustomerModel(
                        id: 2,
                        firstName: fNameEditingController.text,
                        lastName: lNameEditingController.text,
                        email: emailEditingController.text
                    );

                    await DatabaseHelper.instance.addCustomer(customer);
                  },
                  child: Text("Save"),
                
                ),

                Container(
                  height: 400,
                  child: FutureBuilder(
                    future: DatabaseHelper.instance.getCustomer(),
                    builder: (BuildContext context, AsyncSnapshot<List<CustomerModel>> snapshot){

                      if(!snapshot.hasData) {
                        return Text("Loading......");
                      }
                      return ListView(
                        children: snapshot.data!.map((customer) {
                          return ListTile(
                            title: Text(customer.firstName ?? ""),
                            subtitle: Text(customer.lastName ?? "" ),
                          );
                        }).toList(),
                      );
                    }
                  )
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

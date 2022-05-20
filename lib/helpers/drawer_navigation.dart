import 'package:flutter/material.dart';
import 'package:to_do_app/screen/categories_screen.dart';
import 'package:to_do_app/screen/home_screen.dart';
import 'package:to_do_app/screen/todo_categories.dart';
import '../services/category_service.dart';

class DrawerNavigation extends StatefulWidget {
  //const DrawerNavigation({Key? key}) : super(key: key);
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();

}

class _DrawerNavigationState extends State<DrawerNavigation> {

  List<Widget> _categoryList = <Widget>[];
  CategoryService _categoryService = CategoryService();

  @override
  initState(){
    super.initState();
    getCategories();
  }

  getCategories() async {
    var categories = await _categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: ()=>Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new TodoCategories(category: category["name"],))),
          child: ListTile(
            title: Text(category["name"]),
          ),
        ));
      });
    });
  }

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
              ),
              accountName: Text('test'),
              accountEmail: Text('admin.admin'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen())
              ),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap:  () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())
              ),
            ),
            Divider(),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}

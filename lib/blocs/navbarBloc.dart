import 'dart:async';

enum NavBarItem { Home, Collab, Events, Profile }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.Home;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.Home);
        break;

      case 1:
        _navBarController.sink.add(NavBarItem.Collab);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.Events);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.Profile);
        break;
    }
  }

  close() {
    _navBarController.close();
  }
}

import 'package:flutter/material.dart';

enum TabItem { home, notif, profile }

const Map<TabItem, String> tabName = {
  TabItem.home: 'home',
  TabItem.notif: 'notif',
  TabItem.profile: 'profile',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.red,
  TabItem.notif: Colors.green,
  TabItem.profile: Colors.blue,
};


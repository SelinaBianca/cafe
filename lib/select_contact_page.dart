import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class SelectContactPage extends StatefulWidget {
  @override
  _SelectContactPageState createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  Iterable<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  void _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      _fetchContacts();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    final status = await Permission.contacts.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.contacts.request();
      return result;
    }
    return status;
  }

  void _handleInvalidPermissions(PermissionStatus status) {
    if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
      _showPermissionDialog(
        status == PermissionStatus.denied
            ? 'Please enable contacts access permission in system settings'
            : 'Contact permissions are permanently denied. Please enable it from the system settings.',
      );
    }
  }

  void _showPermissionDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Permissions error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (message.contains('permanently')) // Add settings option if permanently denied
            TextButton(
              child: Text('Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            )
        ],
      ),
    );
  }

  void _fetchContacts() async {
    try {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } catch (e) {
      print('Failed to fetch contacts: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch contacts')),
      );
    }
  }

  void _shareAppWithContact(Contact contact) {
    final phoneNumber = contact.phones?.isNotEmpty == true ? contact.phones!.first.value : null;
    if (phoneNumber != null) {
      Share.share('Check out this amazing coffee shop app: [App Link]');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected contact does not have a phone number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Contact'),
      ),
      body: _contacts != null
          ? _contacts!.isNotEmpty
          ? ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, index) {
          Contact contact = _contacts!.elementAt(index);
          return ListTile(
            title: Text(contact.displayName ?? 'No name'),
            subtitle: contact.phones?.isNotEmpty == true
                ? Text(contact.phones!.first.value ?? 'No phone number')
                : Text('No phone number'),
            onTap: () {
              _shareAppWithContact(contact);
            },
          );
        },
      )
          : Center(child: Text('No contacts found'))
          : Center(child: CircularProgressIndicator()),
    );
  }
}

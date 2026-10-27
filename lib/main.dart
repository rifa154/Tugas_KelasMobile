
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

const Color primaryGreen = Color(0xFF075E54);
const Color lightGreen = Color(0xFF128C7E);
const Color backgroundColor = Color(0xFFF5F7F6);

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
        ),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  String searchQuery = '';

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Aulia Putri',
      'message': 'Oke, nanti aku kabari ya!',
      'time': '07.30',
      'icon': Icons.person,
      'color': Colors.pink,
      'unread': 2,
    },
    {
      'name': 'Kelompok Kuliah',
      'message': 'Besok jangan lupa tugasnya.',
      'time': '07.15',
      'icon': Icons.groups,
      'color': Colors.blue,
      'unread': 4,
    },
    {
      'name': 'Rizky',
      'message': 'Makasih banyak 😊',
      'time': 'Kemarin',
      'icon': Icons.person,
      'color': Colors.orange,
      'unread': 0,
    },
    {
      'name': 'Ibu',
      'message': 'Sudah sarapan belum?',
      'time': 'Kemarin',
      'icon': Icons.person,
      'color': Colors.purple,
      'unread': 1,
    },
    {
      'name': 'Sahabat',
      'message': 'Sampai ketemu nanti!',
      'time': 'Senin',
      'icon': Icons.person,
      'color': Colors.teal,
      'unread': 0,
    },
  ];

  final List<String> titles = [
    'Chats',
    'Updates',
    'Calls',
  ];

  void openChat(Map<String, dynamic> chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          contactName: chat['name'] as String,
          avatarColor: chat['color'] as Color,
          avatarIcon: chat['icon'] as IconData,
        ),
      ),
    );
  }

  Widget profileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      decoration: const BoxDecoration(
        color: primaryGreen,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 42,
              color: primaryGreen,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Nur Arifah',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'NPM: 5520124024',
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            'Teknik Informatika',
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            'Universitas Suryakancana',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          profileHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Text(
              'PENGATURAN',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Account'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Privacy'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none),
            title: const Text('Notifications'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About ChatApp'),
            subtitle: Text('Versi 1.0.0'),
          ),
        ],
      ),
    );
  }

  Widget buildEndDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            color: primaryGreen,
            child: const SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.filter_list,
                    color: Colors.white,
                    size: 36,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Filter Percakapan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pilih kategori pesan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.all_inbox),
            title: const Text('Semua Pesan'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.mark_chat_unread_outlined),
            title: const Text('Belum Dibaca'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.star_border),
            title: const Text('Pesan Berbintang'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.groups_outlined),
            title: const Text('Grup'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget buildChatList() {
    final filteredChats = chats.where((chat) {
      return (chat['name'] as String)
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    if (filteredChats.isEmpty) {
      return const Center(
        child: Text('Percakapan tidak ditemukan'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: filteredChats.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        indent: 82,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final chat = filteredChats[index];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: CircleAvatar(
            radius: 27,
            backgroundColor: (chat['color'] as Color).withValues(
              alpha: 0.15,
            ),
            child: Icon(
              chat['icon'] as IconData,
              color: chat['color'] as Color,
              size: 29,
            ),
          ),
          title: Text(
            chat['name'] as String,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              chat['message'] as String,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat['time'] as String,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 7),
              if ((chat['unread'] as int) > 0)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: lightGreen,
                  child: Text(
                    '${chat['unread']}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          onTap: () => openChat(chat),
        );
      },
    );
  }

  Widget buildUpdates() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Status Terbaru',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: lightGreen,
            child: Icon(Icons.add, color: Colors.white),
          ),
          title: const Text('Status Saya'),
          subtitle: const Text('Ketuk untuk menambahkan status'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur status demo')),
            );
          },
        ),
        const Divider(),
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pink,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('Aulia Putri'),
          subtitle: Text('Baru saja'),
        ),
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('Rizky'),
          subtitle: Text('15 menit yang lalu'),
        ),
      ],
    );
  }

  Widget buildCalls() {
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFE0F2F1),
            child: Icon(Icons.person, color: primaryGreen),
          ),
          title: Text('Aulia Putri'),
          subtitle: Text('Panggilan suara keluar'),
          trailing: Icon(Icons.call, color: primaryGreen),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFE3F2FD),
            child: Icon(Icons.person, color: Colors.blue),
          ),
          title: Text('Rizky'),
          subtitle: Text('Panggilan video masuk'),
          trailing: Icon(Icons.videocam, color: primaryGreen),
        ),
      ],
    );
  }

  Widget buildBody() {
    switch (selectedIndex) {
      case 0:
        return buildChatList();
      case 1:
        return buildUpdates();
      default:
        return buildCalls();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wideScreen = constraints.maxWidth >= 700;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              wideScreen ? 'ChatApp • ${titles[selectedIndex]}' : 'ChatApp',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Cari percakapan',
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ChatSearchDelegate(chats, openChat),
                  );
                },
              ),
              IconButton(
                tooltip: 'Kamera',
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur kamera demo'),
                    ),
                  );
                },
              ),
              Builder(
                builder: (context) => IconButton(
                  tooltip: 'Filter',
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ],
          ),
          drawer: buildDrawer(),
          endDrawer: buildEndDrawer(),
          body: Row(
            children: [
              if (wideScreen)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => selectedIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: Colors.white,
                  selectedIconTheme: const IconThemeData(
                    color: primaryGreen,
                  ),
                  selectedLabelTextStyle: const TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.chat_outlined),
                      selectedIcon: Icon(Icons.chat),
                      label: Text('Chats'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.circle_outlined),
                      selectedIcon: Icon(Icons.circle),
                      label: Text('Updates'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.call_outlined),
                      selectedIcon: Icon(Icons.call),
                      label: Text('Calls'),
                    ),
                  ],
                ),
              Expanded(
                child: Column(
                  children: [
                    if (!wideScreen)
                      Container(
                        color: primaryGreen,
                        child: Row(
                          children: List.generate(3, (index) {
                            return Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() => selectedIndex = index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      titles[index].toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: selectedIndex == index
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    if (selectedIndex == 0)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: TextField(
                          onChanged: (value) {
                            setState(() => searchQuery = value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari nama kontak...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    Expanded(child: buildBody()),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: wideScreen
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  backgroundColor: Colors.white,
                  indicatorColor: const Color(0xFFD9F1E9),
                  onDestinationSelected: (index) {
                    setState(() => selectedIndex = index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.chat_outlined),
                      selectedIcon: Icon(Icons.chat),
                      label: 'Chats',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.circle_outlined),
                      selectedIcon: Icon(Icons.circle),
                      label: 'Updates',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.call_outlined),
                      selectedIcon: Icon(Icons.call),
                      label: 'Calls',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class ChatSearchDelegate extends SearchDelegate<void> {
  final List<Map<String, dynamic>> chats;
  final void Function(Map<String, dynamic>) onSelect;

  ChatSearchDelegate(this.chats, this.onSelect);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = chats.where((chat) {
      return (chat['name'] as String)
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    return ListView(
      children: results.map((chat) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: chat['color'] as Color,
            child: Icon(
              chat['icon'] as IconData,
              color: Colors.white,
            ),
          ),
          title: Text(chat['name'] as String),
          subtitle: Text(chat['message'] as String),
          onTap: () {
            close(context, null);
            onSelect(chat);
          },
        );
      }).toList(),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String contactName;
  final Color avatarColor;
  final IconData avatarIcon;

  const ChatDetailScreen({
    super.key,
    required this.contactName,
    required this.avatarColor,
    required this.avatarIcon,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {'text': 'Hai, apa kabar?', 'mine': false},
    {'text': 'Baik, kamu bagaimana?', 'mine': true},
    {'text': 'Aku juga baik 😊', 'mine': false},
  ];

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({'text': text, 'mine': true});
      messageController.clear();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                widget.avatarIcon,
                color: widget.avatarColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.contactName,
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEAF1ED),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final mine = message['mine'] as bool;

                  return Align(
                    alignment: mine
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: mine ? const Color(0xFFD9FDD3) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(14),
                          topRight: const Radius.circular(14),
                          bottomLeft: Radius.circular(mine ? 14 : 3),
                          bottomRight: Radius.circular(mine ? 3 : 14),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        message['text'] as String,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: primaryGreen,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onSubmitted: (_) => sendMessage(),
                        decoration: InputDecoration(
                          hintText: 'Ketik pesan...',
                          filled: true,
                          fillColor: backgroundColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: primaryGreen,
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

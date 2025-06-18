import 'package:altfit/register.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'program_detail_screen.dart';
import 'register.dart';
import 'profile_screen.dart';

class ProgramsScreen extends StatefulWidget {
  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String searchQuery = '';
  String selectedGoal = 'All';
  bool showDropdown = false;
  int _selectedIndex = 0;

  final List<String> goals = [
    'All',
    'Muscle Gain',
    'Weight Loss',
    'Strength',
    'ABS'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _tabController!.animateTo(1); // Home = Explore
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[200],
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => RegisterPage()),
          ),
        ),
        actions: [
          Switch(
            value: isDark,
            onChanged: themeProvider.toggleTheme,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'My Programs'),
            Tab(text: 'Explore Programs'),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Explore to find your new goal',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for programs, trainers, goals...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) =>
                        setState(() => searchQuery = val.toLowerCase()),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => setState(() => showDropdown = !showDropdown),
                ),
              ],
            ),
          ),
          if (showDropdown)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: DropdownButton<String>(
                value: selectedGoal,
                onChanged: (val) => setState(() => selectedGoal = val!),
                items: goals
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
              ),
            ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildProgramList('my'),
                buildProgramList('explore'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Tracker'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildProgramList(String category) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('programs')
          .where('category', isEqualTo: category)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final docs = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final title = (data['title'] ?? '').toLowerCase();
          final trainer = (data['trainer'] ?? '').toLowerCase();
          final goal = (data['goal'] ?? '').toString();
          return (title.contains(searchQuery) || trainer.contains(searchQuery)) &&
              (selectedGoal == 'All' || goal == selectedGoal);
        }).toList();

        if (docs.isEmpty) return const Center(child: Text('No programs found'));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (context, i) {
            final data = docs[i].data() as Map<String, dynamic>;
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProgramDetailScreen(programData: data),
                ),
              ),
              child: buildProgramCard(data),
            );
          },
        );
      },
    );
  }

  Widget buildProgramCard(Map<String, dynamic> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  data['imageUrl'] ?? '',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('₹${data['price'] ?? '0'}',
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['title'] ?? '',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(data['trainerImage'] ?? ''),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 8),
                    Text(data['trainer'] ?? '', style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    buildChip(data['goal'], Colors.blue, Icons.flag),
                    buildChip(data['difficulty'], Colors.green, Icons.fitness_center),
                    buildChip(data['duration'], Colors.orange, Icons.timer),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildChip(String? label, Color color, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(label ?? ''),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Common Widgets v2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      home: const CommonWidgetsProjectPage(),
    );
  }
}

class CommonWidgetsProjectPage extends StatefulWidget {
  const CommonWidgetsProjectPage({super.key});

  @override
  State<CommonWidgetsProjectPage> createState() =>
      _CommonWidgetsProjectPageState();
}

class _CommonWidgetsProjectPageState extends State<CommonWidgetsProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _classController = TextEditingController();
  int? _selectedGridIndex;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _classController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final nim = _classController.text.trim();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data terkirim: $name | $nim | $email'),
      ));
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _classController.clear();
    }
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'Profil Saya':
        _showInfo('Membuka Profil Saya');
        break;
      case 'Pengaturan':
        _showInfo('Membuka Pengaturan');
        break;
      case 'Notifikasi':
        _showInfo('Membuka Notifikasi');
        break;
      case 'Bantuan':
        _showInfo('Membuka Bantuan');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final crossAxisCount = orientation == Orientation.portrait ? 2 : 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => _showInfo('Menu diklik'),
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        title: const Text('l200230156_widgets'),
        actions: [
          IconButton(
            onPressed: () => _showInfo('Pencarian diklik'),
            icon: const Icon(Icons.search, color: Colors.lightBlueAccent),
          ),
          IconButton(
            onPressed: () => _showInfo('Tidak ada notifikasi baru'),
            icon: const Icon(Icons.notifications, color: Colors.amber),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: _onMenuSelected,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'Profil Saya',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Color(0xFF5B2C90)),
                    SizedBox(width: 10),
                    Text('Profil Saya'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Pengaturan',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Color(0xFF00897B)),
                    SizedBox(width: 10),
                    Text('Pengaturan'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Notifikasi',
                child: Row(
                  children: [
                    Icon(Icons.notifications, color: Color(0xFFF9A825)),
                    SizedBox(width: 10),
                    Text('Notifikasi'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Bantuan',
                child: Row(
                  children: [
                    Icon(Icons.help, color: Color(0xFFE91E63)),
                    SizedBox(width: 10),
                    Text('Bantuan'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 86,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xFF1565C0),
              ),
              child: const Center(
                child: Text(
                  'Hello Flutter!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 28, color: Colors.black87),
                  children: [
                    TextSpan(text: 'Mobile '),
                    TextSpan(
                      text: 'Programming ',
                      style: TextStyle(
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Flutter!',
                      style: TextStyle(
                        color: Color(0xFFEF6C00),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Nama lengkap', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama wajib diisi';
                      }
                      if (value.trim().length < 3) {
                        return 'Nama minimal 3 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email wajib diisi';
                      }
                      if (!RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(value.trim())) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _classController,
                    decoration: const InputDecoration(
                      labelText: 'NIM',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'NIM wajib diisi';
                      }
                      if (value.trim().toUpperCase() != 'L200230153') {
                        return 'NIM harus L200230153';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Simpan Data'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.9,
              ),
              itemBuilder: (context, index) {
                final labels = [
                  'Mobile',
                  'Web',
                  'Database',
                  'Cloud',
                  'UI/UX',
                  'API',
                  'Git',
                  'AI',
                ];
                final icons = [
                  Icons.calculate,
                  Icons.language,
                  Icons.save,
                  Icons.cloud,
                  Icons.palette,
                  Icons.api,
                  Icons.construction,
                  Icons.smart_toy,
                ];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _selectedGridIndex == index
                          ? Colors.orange
                          : const Color(0xFF54C4A7),
                      width: _selectedGridIndex == index ? 2 : 1,
                    ),
                  ),
                  child: Material(
                    color: _selectedGridIndex == index
                        ? const Color(0xFFFFF7ED)
                        : const Color(0xFFCCE0DB),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          _selectedGridIndex = index;
                        });
                        _showInfo('Kamu pilih ${labels[index]}');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icons[index], color: const Color(0xFF065F53)),
                          const SizedBox(height: 6),
                          Text(
                            labels[index],
                            style: const TextStyle(
                              color: Color(0xFF065F53),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

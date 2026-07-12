import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/joke_model.dart';
import '../services/joke_service.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final JokeService _jokeService = JokeService();
  Joke? _currentJoke;
  bool _isLoading = false;
  String _selectedCategory = 'Any';
  List<Joke> _savedJokes = [];
  final List<Joke> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadInitialJoke();
  }

  Future<void> _loadInitialJoke() async {
    await _fetchJoke();
  }

  Future<void> _fetchJoke() async {
    setState(() => _isLoading = true);
    try {
      final joke = await _jokeService.getJokeByCategory(_selectedCategory);
      if (mounted) {
        setState(() {
          _currentJoke = joke;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading joke: $e')),
        );
      }
    }
  }

  void _saveJoke() {
    if (_currentJoke != null) {
      _currentJoke!.savedAt = DateTime.now();
      if (!_favorites.any((j) => j.id == _currentJoke!.id)) {
        setState(() {
          _favorites.add(_currentJoke!);
          _savedJokes.add(_currentJoke!);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Joke saved!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Joke already saved!')),
        );
      }
    }
  }

  void _shareJoke() {
    if (_currentJoke != null) {
      Share.share(_currentJoke!.getFullText());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Generator'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => _showSavedJokes(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category Selector
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Category',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _jokeService.getCategories().map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: _selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                              _fetchJoke();
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Joke Display
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              )
            else if (_currentJoke != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade100, Colors.purple.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _currentJoke!.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Joke Text
                        if (_currentJoke!.type == 'twopart')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentJoke!.setup ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _currentJoke!.delivery ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            _currentJoke!.joke ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        const SizedBox(height: 16),

                        // Safety Badge
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _currentJoke!.safe
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _currentJoke!.safe ? 'Safe' : 'Explicit',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _currentJoke!.safe
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text('No joke available. Try again!'),
              ),

            const SizedBox(height: 32),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _saveJoke,
                        icon: const Icon(Icons.favorite_outline),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _shareJoke,
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _fetchJoke,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Get Another Joke'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showSavedJokes() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SavedJokesSheet(jokes: _favorites),
    );
  }
}

class SavedJokesSheet extends StatelessWidget {
  final List<Joke> jokes;

  const SavedJokesSheet({super.key, required this.jokes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saved Jokes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (jokes.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('No saved jokes yet!'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        joke.getFullText(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(joke.category),
                      trailing: IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () => Share.share(joke.getFullText()),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

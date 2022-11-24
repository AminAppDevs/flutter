import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TestTheme extends StatelessWidget {
  const TestTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('السلام عليكم'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'رقم الجوال',
                prefixIcon: Icon(Ionicons.phone_portrait_outline),
              ),
            ),
            const SizedBox(height: 30),
            Text('نص كبير', style: Theme.of(context).textTheme.displayLarge),
            Text('نص متوسط', style: Theme.of(context).textTheme.displayMedium),
            Text('نص صغير', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 30),
            Text('ترويسة كبيرة', style: Theme.of(context).textTheme.headlineLarge),
            Text('ترويسة متوسطة', style: Theme.of(context).textTheme.headlineMedium),
            Text('ترويسة صغيرة', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 30),
            Text('عنوان كبير', style: Theme.of(context).textTheme.titleLarge),
            Text('عنوان متوسط', style: Theme.of(context).textTheme.titleMedium),
            Text('عنوان صغير', style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}

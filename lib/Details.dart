import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final int price;

  const Details({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String? selectedcolor;
  final Map<String, String> colors = {
    'Red': 'red',
    'Blue': 'blue',
    'Green': 'green',
    'Yellow': 'yellow',
  };

  String? delivery;
  final Map<String, int> deliveryOptions = {
    'cash': 1,
    'card': 2,
    'online': 3
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.image.isNotEmpty
                        ? widget.image
                        : 'https://via.placeholder.com/200',
                    width: 220,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                widget.title.isNotEmpty ? widget.title : '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.subtitle.isNotEmpty ? widget.subtitle : '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                '\$${widget.price}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Choose color',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedcolor,
                hint: const Text('Choose a color'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12),
                ),
                items: colors.keys
                    .map(
                      (colorName) => DropdownMenuItem<String>(
                        value: colorName,
                        child: Text(colorName),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedcolor = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              Text(
                'Delivery method',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              Column(
                children: deliveryOptions.keys.map((v) {
                  return RadioListTile<String>(
                    title: Text(v),
                    value: v,
                    groupValue: delivery,
                    onChanged: (String? value) {
                      setState(() {
                        delivery = value;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  'Selected: $delivery | Color: $selectedcolor',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item purchased successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

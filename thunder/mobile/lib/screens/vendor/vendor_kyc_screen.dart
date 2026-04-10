import "package:flutter/material.dart";

class VendorKycScreen extends StatefulWidget {
  const VendorKycScreen({super.key});

  @override
  State<VendorKycScreen> createState() => _VendorKycScreenState();
}

class _VendorKycScreenState extends State<VendorKycScreen> {
  int _currentStep = 0;
  final _nameController = TextEditingController();
  final _experienceController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = ["Cleaning", "Appliances", "Plumber", "Electrician", "Carpenter", "Salon", "Pest Control", "Festival"];
  final List<String> _cleaningSubServices = [
    "Home Cleaning",
    "Washbasin Clean", "Bathroom Door Clean", "Bathroom Mirror Clean", "Exhaust Fan (Bathroom)", "Bathroom Tiles & Floor", "Fittings & Fixtures", "Full Bathroom", "Bathroom Combo",
    "Gas Stove Clean", "Chimney Clean", "Fridge Clean", "Tap Clean", "Kitchen Cabinets & Trolleys", "Kitchen Windows & Tiles", "Kitchen Exhaust Fan", "Full Kitchen", "Kitchen Combo"
  ];
  final List<String> _plumberSubServices = [
    "Plumber work", "Repairs", "Installations", "Uninstallations", "Tap mixer", "Toilet", "Bath / Shower", "Bath accessories", "Basin and sink", "Drainage and blockage", "Leakage fixes", "Water tank cleaning", "Motor installation"
  ];
  final List<String> _applianceSubServices = [
    "AC Service", "AC Repair", "AC Gas Refill", "AC Install/Uninstall", "AC Plumbing", "Annual AC Plan", "Washing Machine Clean", "Washing Machine Repair", "Washing Machine Install", "Refrigerator Clean", "Refrigerator Repair", "Fridge Power Issue", "Fridge Excess Cooling", "Geyser Service", "Purifier Repair", "Air Cooler Clean"
  ];
  final List<String> _electricianSubServices = [
    "Electrical Work", "AC Service/Repair", "Washing Machine", "Refrigerator", "Geyser", "Purifier", "Air Cooler", "Switch/Wiring", "MCB Reset", "Plumber Work"
  ];
  final List<String> _pestSubServices = [
    "Pest Control Services", "Cockroach control", "Ant control", "General insect", "Kitchen & bathroom", "Full home (1/2/3 BHK)", "Sink & drainage", "Bed bug treatment", "Termite control", "Rodent control", "Mosquito control", "Lizard control", "Herbal / Odorless", "Disinfection"
  ];
  final List<String> _carpenterSubServices = [
    "Carpenter work", "Cupboard repair", "Lock/Latch fixing", "Drawer repair", "Channel replacement", "Sliding wardrobe", "Hinge repair", "Kitchen cabinet fixing", "Curtain rod install", "Door installation/repair", "Bed/Sofa repair", "Furniture modification"
  ];
  final List<String> _salonSubServices = [
    "Cleanup/Facial", "Detan/Bleach", "Full body waxing", "Threading", "Manicure/Pedicure", "Foot massage", "Haircut", "Hair colour", "Keratin/Smoothening", "Nail extensions", "Party makeup", "Bridal makeup", "Saree draping", "Body massage", "Kids haircut"
  ];
  final List<String> _festivalSubServices = [
    "Festival Lighting", "Balcony lights", "Mandir pooja lights", "Outdoor decor", "Removal services", "Plug point setup", "Load handling", "Wooden supports", "Painting touch-up"
  ];
  final Set<String> _selectedSubServices = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Partner Onboarding")),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() => _currentStep++);
          } else {
            _showSuccess(context);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: [
          Step(
            title: const Text("Basic Profile"),
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                const SizedBox(height: 16),
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder())),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: "Main Category", border: OutlineInputBorder()),
                  items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                ),
                const SizedBox(height: 16),
                TextField(controller: _experienceController, decoration: const InputDecoration(labelText: "Years of Experience", border: OutlineInputBorder()), keyboardType: TextInputType.number),
              ],
            ),
          ),
          Step(
            title: const Text("Select Services"),
            isActive: _currentStep >= 1,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedCategory == "Cleaning") ...[
                  const Text("Which cleaning services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_cleaningSubServices),
                ] else if (_selectedCategory == "Plumber") ...[
                  const Text("Which plumbing services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_plumberSubServices),
                ] else if (_selectedCategory == "Appliances") ...[
                  const Text("Which appliance services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_applianceSubServices),
                ] else if (_selectedCategory == "Electrician") ...[
                  const Text("Which electrical services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_electricianSubServices),
                ] else if (_selectedCategory == "Pest Control") ...[
                  const Text("Which pest control services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_pestSubServices),
                ] else if (_selectedCategory == "Carpenter") ...[
                  const Text("Which carpenter services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_carpenterSubServices),
                ] else if (_selectedCategory == "Salon") ...[
                  const Text("Which salon services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_salonSubServices),
                ] else if (_selectedCategory == "Festival") ...[
                  const Text("Which festival services do you provide?", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._buildServiceCheckboxes(_festivalSubServices),
                ] else ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("Service details will be configured after approval for this category."),
                  ),
                ],
              ],
            ),
          ),
          Step(
            title: const Text("ID Proof"),
            isActive: _currentStep >= 2,
            content: InkWell(
              onTap: () {}, // Dummy photo pick
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300, style: BorderStyle.none)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, size: 48, color: theme.colorScheme.primary),
                    const SizedBox(height: 12),
                    const Text("Upload Aadhaar / ID Card"),
                    const Text("Front and Back", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: const Text("Finalize"),
            isActive: _currentStep >= 3,
            content: const Column(
              children: [
                Icon(Icons.verified_user_outlined, size: 64, color: Colors.green),
                SizedBox(height: 16),
                Text("Ready to go!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Your profile will be live once admin verifies your documents.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildServiceCheckboxes(List<String> services) {
    return services.map((service) => CheckboxListTile(
      title: Text(service),
      value: _selectedSubServices.contains(service),
      onChanged: (val) {
        setState(() {
          if (val == true) _selectedSubServices.add(service);
          else _selectedSubServices.remove(service);
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
    )).toList();
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Application Submitted"),
        content: Text("We will verify your details and the ${_selectedSubServices.length} services you selected within 24 hours."),
        actions: [
          TextButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: const Text("Done")),
        ],
      ),
    );
  }
}

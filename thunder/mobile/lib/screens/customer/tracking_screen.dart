import "dart:async";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "../../services/location_simulator.dart";

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  
  static const LatLng _customerLocation = LatLng(28.5284, 77.2197); // Saket, New Delhi
  static const LatLng _providerStartLocation = LatLng(28.5144, 77.2067); // Near IGNOU
  
  LatLng _currentProviderLocation = _providerStartLocation;
  StreamSubscription<LatLng>? _subscription;

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers = {
      const Marker(
        markerId: MarkerId("customer"),
        position: _customerLocation,
        infoWindow: InfoWindow(title: "My Home"),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: const MarkerId("provider"),
        position: _currentProviderLocation,
        infoWindow: const InfoWindow(title: "Service Provider"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    };

    // Start simulation
    _subscription = LocationSimulator.getProviderLocationStream(
      start: _providerStartLocation,
      end: _customerLocation,
      steps: 40,
    ).listen((newLoc) {
      setState(() {
        _currentProviderLocation = newLoc;
        _markers = {
          const Marker(
            markerId: MarkerId("customer"),
            position: _customerLocation,
            infoWindow: InfoWindow(title: "My Home"),
          ),
          Marker(
            markerId: const MarkerId("provider"),
            position: _currentProviderLocation,
            infoWindow: const InfoWindow(title: "Partner is on the way"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          ),
        };
      });
      _moveCamera(newLoc);
    });
  }

  Future<void> _moveCamera(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(pos));
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Your Partner"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _providerStartLocation,
              zoom: 14.4746,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          
          // Floating Status Card
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Colors.blue),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Amit Kumar",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "AC Specialist • 4.8★",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.phone, color: Colors.green),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Arriving in",
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                            ),
                            const Text(
                              "8-12 mins",
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

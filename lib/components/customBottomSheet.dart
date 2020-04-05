import 'package:air_vision/models/aircraftState.dart';
import 'package:air_vision/models/flightInfo.dart';
import 'package:air_vision/services/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './customListTile.dart';

class CustomBottomSheet extends StatefulWidget {
  final AircraftState aircraft;

  const CustomBottomSheet(this.aircraft);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  Api _api = Api();
  FlightInfo info;

  @override
  void initState() {
    super.initState();
    _api.getSpecificFlightInfo(widget.aircraft.icao24).then((res) {
      setState(() {
        info = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double knots = widget.aircraft.velocity * 1.94384;
    double vKnots = widget.aircraft.verticalRate * 1.94384;

    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20)),
          child: Container(
            color: Colors.white,
            height: 70.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "FLIGHT INFORMATION",
                    style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Divider(
                      color: Colors.black,
                      thickness: 3.0,
                      endIndent: 150.0,
                      indent: 150.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(children: <Widget>[
            CustomListTile(Icons.label, widget.aircraft.icao24),
            CustomListTile(
                Icons.location_on,
                (widget.aircraft.position[0].toStringAsFixed(3) +
                    ', ' +
                    widget.aircraft.position[1].toStringAsFixed(3) +
                    ', ' +
                    widget.aircraft.position[2].toStringAsFixed(1) +
                    'm')),
            widget.aircraft.velocity != null
                ? CustomListTile(
                    Icons.network_check,
                    widget.aircraft.velocity.toStringAsFixed(2) +
                        ' m/s, ' +
                        knots.toStringAsFixed(2) +
                        ' kt')
                : Container(),
            widget.aircraft.verticalRate != null
                ? CustomListTile(
                    Icons.flight_takeoff,
                    widget.aircraft.verticalRate.toStringAsFixed(2) +
                        ' m/s, ' +
                        vKnots.toStringAsFixed(2) +
                        ' kt')
                : Container(),
            info != null
                ? Column(
                    children: <Widget>[
                      CustomListTile(Icons.check_circle,
                          'Request succesfull - ' + info.arrivalAirport.name),
                    ],
                  )
                : CustomListTile(
                    Icons.error, 'No additional information found'),
          ]),
        ),
      ],
    );
  }
}

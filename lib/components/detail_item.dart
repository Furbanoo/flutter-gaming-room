import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? name;
  final VoidCallback onPressed;
  const DetailItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        width: 160,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(
            width: 1.0,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  name != null
                      ? Text(
                          name!,
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        )
                      : Container(),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

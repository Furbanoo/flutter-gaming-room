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
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  name != null
                      ? Text(
                          name!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10.0),
                        )
                      : Container(),
                ],
              ),
              const Spacer(),
              const Icon(
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

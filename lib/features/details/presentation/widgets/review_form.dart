import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../provider.dart';
import '../notifiers/notifiers.dart';

class ReviewForm extends StatefulWidget {
  final String id;

  const ReviewForm({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read(reviewsProvider.notifier).id = widget.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: reviewsProvider,
      onChange: (context, state) {
        if (state is ReviewsLoaded) {
          _formKey.currentState?.reset();
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardTheme.shadowColor!,
              blurRadius: 5,
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  style: Theme.of(context).primaryTextTheme.headline4,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: Theme.of(context).primaryTextTheme.headline4,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    filled: true,
                    fillColor: Theme.of(context).canvasColor,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write your name!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    context.read(reviewsProvider.notifier).name = value;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  style: Theme.of(context).primaryTextTheme.headline4,
                  decoration: InputDecoration(
                    hintText: 'Review',
                    hintStyle: Theme.of(context).primaryTextTheme.headline4,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    filled: true,
                    fillColor: Theme.of(context).canvasColor,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Write your review!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    context.read(reviewsProvider.notifier).review = value;
                  },
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 40),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.04),
                  ),
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    context.read(reviewsProvider.notifier).sendReview();
                  }
                },
                child: Text(
                  'Send',
                  style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

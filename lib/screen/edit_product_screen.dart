// //4.Form

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //5.
  final _priceFocusNode = FocusNode();
  //6
  final _descFocusNode = FocusNode();
  //7
  final _imageUrlController = TextEditingController();
  //7
  final _imageurlFocus = FocusNode();
  //8
  final _form = GlobalKey<FormState>();
  //8
  Product _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var _initVal = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
//6
  var isinit = true;
  var isLoading = false;
  @override
  void initState() {
    // TODO: add listener
    //everytime whn focus changes _updateform willl be called
    _imageurlFocus.addListener(_updateimageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isinit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .getItemById(productId);
        _initVal = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl':_editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: disposing
    _imageurlFocus.removeListener(_updateimageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageurlFocus.dispose();
    super.dispose();
  }

  void _updateimageUrl() {
    if (!_imageurlFocus.hasFocus) {
      setState(() {});
    }
  }

//8
  void _saveForm() {
    //9
    final isVal = _form.currentState.validate();
    if (!isVal) {
      return;
    }
    _form.currentState.save();

    setState(() {
      isLoading = true;
      print('set state of save $isLoading');
    });
    // print(_editedProduct.title);
    // print(_editedProduct.price);
    // print(_editedProduct.description);
    // print(_editedProduct.imageUrl);
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      print(isLoading);
      //not working
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)//catching error
          .catchError((error) {
        return showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Error occured'),
                  content: Text('Something went wrong'),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Close'))
                  ],
                ));
      }).then((_) {
        print(mounted);

        setState(() {
          print('set state of add $isLoading');
          isLoading = false;
          print('set state of add $isLoading');
        });

        Navigator.of(context).pop();
      });
      //Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                //8
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initVal['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      //5.
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      //9 validating
                      validator: (val) {
                        return val.isEmpty ? 'Please provide a value' : null;
                      },
                      onSaved: (val) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: val,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    //5.
                    TextFormField(
                      initialValue: _initVal['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      //5 managing form focus
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descFocusNode);
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(val) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(val) <= 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(val),
                            isFavorite: _editedProduct.isFavorite,
                            imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    //6
                    TextFormField(
                      initialValue: _initVal['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descFocusNode,
                      onSaved: (val) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            isFavorite: _editedProduct.isFavorite,
                            description: val,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl);
                      },
                      validator: (val) {
                        return val.isEmpty ? 'Enter description' : null;
                      },
                    ),
                    //7
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a url')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: _initVal['imageUrl'],
                            decoration: InputDecoration(labelText: 'Image Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageurlFocus,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (val) {
                              if (val.isEmpty)
                                return 'Please enter a imnage url';
                              if (!val.startsWith('http') &&
                                  val.startsWith('https'))
                                return 'Please enter a valid url';
                              return null;
                            },
                            onSaved: (val) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: val);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

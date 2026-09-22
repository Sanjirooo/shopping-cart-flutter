import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget{
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>{
  int headphone = 0;
  int laptop = 0;
  int mouse = 0;

  int likeHeadphone = 8;
  int likeLaptop = 8;
  int likeMouse = 5;

  bool headphoneLike = false;
  bool laptopLike = false;
  bool mouseLike = false;

  bool headphoneHighlight = false;
  bool laptopHighlight = false;
  bool mouseHighlight = false;

  int hargaHeadphone = 350000;
  int hargaLaptop = 7500000;
  int hargaMouse = 250000;

  int jumlahBarang(){
    return headphone + laptop + mouse;
  }

  int totalHarga(){
    return
      (headphone * hargaHeadphone)
          +
          (laptop * hargaLaptop)
          +
          (mouse * hargaMouse);
  }

  void tampilNotif(String pesan){
    OverlayEntry notif = OverlayEntry(
      builder:(context)=>Positioned(
        top:50,
        left:40,
        right:40,
        child:Material(
          color:Colors.transparent,
          child:Container(
              padding:EdgeInsets.all(15),
              decoration:BoxDecoration(
                color:Colors.black,
                borderRadius:BorderRadius.circular(10),
              ),
              child:Text(
                pesan,
                textAlign:TextAlign.center,
                style:TextStyle(
                  color:Colors.white,
                ),
              )
          ),
        ),
      ),
    );

    Overlay.of(context).insert(notif);
    Future.delayed(
      Duration(seconds:2),
          (){
        notif.remove();
      },
    );
  }

  Widget produk(
      String nama,
      String gambar,
      int harga,
      int jumlah,
      int jumlahLike,
      bool sudahLike,
      bool disorot,
      Function tambah,
      Function kurang,
      Function like
      ){

    return GestureDetector(
      onLongPress:(){
        tampilNotif(
            "$nama dipilih"
        );
      },
      child:Container(
        margin:EdgeInsets.all(10),
        padding:EdgeInsets.all(10),
        height:150,
        decoration:BoxDecoration(
          border:Border.all(
            color: disorot ? Colors.blue : Colors.grey,
            width: disorot ? 2 : 1,
          ),
          borderRadius:BorderRadius.circular(10),
        ),
        child:Row(
          children:[
            Image.network(
              gambar,
              width:100,
              height:100,
            ),
            SizedBox(width:15),
            Expanded(
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    nama,
                    style:TextStyle(
                      fontSize:18,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rp $harga",
                    style:TextStyle(
                      color:Colors.black,
                      fontSize:16,
                    ),
                  ),

                  Spacer(),

                  Row(
                    children:[
                      GestureDetector(
                        onTap:(){
                          like();
                        },
                        child:Row(
                          children:[
                            Icon(
                              sudahLike ? Icons.favorite : Icons.favorite_border,
                              color: sudahLike ? Colors.red : Colors.black,
                            ),
                            Text(
                              "$jumlahLike",
                            ),
                          ],
                        ),
                      ),

                      Spacer(),

                      ElevatedButton(
                        onPressed:(){
                          kurang();
                        },
                        child:Text("-"),
                      ),
                      SizedBox(width:10),
                      Text(
                        "$jumlah",
                        style:TextStyle(
                          fontSize:18,
                        ),
                      ),
                      SizedBox(width:10),
                      ElevatedButton(
                        onPressed:(){
                          tambah();
                        },
                        child:Text("+"),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text(
            "Shopping Cart"
        ),
      ),
      body:Column(
        children:[
          Expanded(
            child:ListView(
              children:[
                produk(
                    "Wireless Headphone",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHHaOKS9hLPAunH8DPNOssIzXtROFoGYhXwsLN5ezu3Q&s=10",
                    hargaHeadphone,
                    headphone,
                    likeHeadphone,
                    headphoneLike,
                    headphoneHighlight,
                        (){
                      setState((){
                        headphone++;
                        headphoneHighlight = true;
                        laptopHighlight = false;
                        mouseHighlight = false;
                      });
                    },
                        (){
                      setState((){
                        if(headphone>0){
                          headphone--;
                        }
                      });
                    },
                        (){
                      setState((){
                        if(headphoneLike){
                          likeHeadphone--;
                          headphoneLike=false;
                        }
                        else {
                          likeHeadphone++;
                          headphoneLike = true;
                        }
                      });
                    }
                ),
                produk(
                    "Laptop ASUS",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ09Mp8Tc9UlmUPEoMyHMQXOEbR5uQctU4celUrpXEjKw&s=10",
                    hargaLaptop,
                    laptop,
                    likeLaptop,
                    laptopLike,
                    laptopHighlight,
                        (){
                      setState((){
                        laptop++;
                        laptopHighlight = true;
                        headphoneHighlight = false;
                        mouseHighlight = false;
                      });
                    },
                        (){
                      setState((){
                        if(laptop>0){
                          laptop--;
                        }
                      });
                    },
                        (){
                      setState((){
                        if(laptopLike){
                          likeLaptop--;
                          laptopLike=false;
                        }
                        else{
                          likeLaptop++;
                          laptopLike=true;
                        }
                      });
                    }
                ),
                produk(
                    "Wireless Mouse",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0rxXotykvIAnNC9Aj2ChyR2pG6qHMTz5tpZLsY62eMw&s=10",
                    hargaMouse,
                    mouse,
                    likeMouse,
                    mouseLike,
                    mouseHighlight,
                        (){
                      setState((){
                        mouse++;
                        mouseHighlight = true;
                        headphoneHighlight = false;
                        laptopHighlight = false;
                      });
                    },
                        (){
                      setState((){
                        if(mouse>0){
                          mouse--;
                        }
                      });
                    },
                        (){
                      setState((){
                        if(mouseLike) {
                          likeMouse--;
                          mouseLike = false;
                        }
                        else{
                          likeMouse++;
                          mouseLike=true;
                        }
                      });
                    }
                ),
              ],
            ),
          ),
          Container(
            padding:EdgeInsets.all(15),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:[
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                        "Total (${jumlahBarang()} produk)"
                    ),
                    Text(
                      "Rp ${totalHarga()}",
                      style:TextStyle(
                        fontSize:20,
                        fontWeight:FontWeight.bold,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed:(){
                  },
                  child:Text(
                      "Checkout"
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height:70,
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              children:[
                Column(
                  children:[
                    Icon(
                      Icons.home,
                      color:Colors.blue,
                    ),
                    Text(
                      "Beranda",
                      style:TextStyle(
                        color:Colors.blue,
                      ),
                    )
                  ],
                ),
                Column(
                  children:[
                    Icon(Icons.grid_view),
                    Text("Kategori")
                  ],
                ),
                Column(
                  children:[
                    Icon(Icons.shopping_cart),
                    Text("Keranjang")
                  ],
                ),
                Column(
                  children:[
                    Icon(Icons.person),
                    Text("Akun")
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
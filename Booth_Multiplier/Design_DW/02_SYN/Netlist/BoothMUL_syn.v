/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP2
// Date      : Wed May 21 23:37:54 2025
/////////////////////////////////////////////////////////////


module BoothMUL ( P, X, Y );
  output [16:0] P;
  input [7:0] X;
  input [7:0] Y;
  wire   mult_x_1_n86, mult_x_1_n84, mult_x_1_n79, mult_x_1_n78, mult_x_1_n76,
         mult_x_1_n73, mult_x_1_n72, mult_x_1_n71, mult_x_1_n70, mult_x_1_n69,
         mult_x_1_n67, mult_x_1_n66, mult_x_1_n64, mult_x_1_n63, mult_x_1_n46,
         mult_x_1_n43, mult_x_1_n42, mult_x_1_n41, mult_x_1_n40, mult_x_1_n39,
         mult_x_1_n38, mult_x_1_n37, mult_x_1_n36, mult_x_1_n35, mult_x_1_n34,
         mult_x_1_n33, mult_x_1_n32, mult_x_1_n31, mult_x_1_n30, mult_x_1_n29,
         mult_x_1_n28, mult_x_1_n27, mult_x_1_n26, mult_x_1_n25, mult_x_1_n24,
         mult_x_1_n23, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121;

  CMPR42X1 mult_x_1_U28 ( .A(mult_x_1_n67), .B(mult_x_1_n86), .C(mult_x_1_n79), 
        .D(mult_x_1_n73), .ICI(mult_x_1_n46), .S(mult_x_1_n43), .ICO(
        mult_x_1_n41), .CO(mult_x_1_n42) );
  CMPR42X1 mult_x_1_U26 ( .A(mult_x_1_n78), .B(mult_x_1_n66), .C(mult_x_1_n72), 
        .D(mult_x_1_n41), .ICI(mult_x_1_n40), .S(mult_x_1_n38), .ICO(
        mult_x_1_n36), .CO(mult_x_1_n37) );
  CMPR42X1 mult_x_1_U23 ( .A(mult_x_1_n71), .B(mult_x_1_n84), .C(mult_x_1_n39), 
        .D(mult_x_1_n36), .ICI(mult_x_1_n35), .S(mult_x_1_n33), .ICO(
        mult_x_1_n31), .CO(mult_x_1_n32) );
  CMPR42X1 mult_x_1_U21 ( .A(mult_x_1_n70), .B(mult_x_1_n64), .C(mult_x_1_n34), 
        .D(mult_x_1_n30), .ICI(mult_x_1_n31), .S(mult_x_1_n28), .ICO(
        mult_x_1_n26), .CO(mult_x_1_n27) );
  CMPR42X1 mult_x_1_U20 ( .A(mult_x_1_n29), .B(mult_x_1_n69), .C(mult_x_1_n63), 
        .D(mult_x_1_n76), .ICI(mult_x_1_n26), .S(mult_x_1_n25), .ICO(
        mult_x_1_n23), .CO(mult_x_1_n24) );
  ADDFX1 U1 ( .A(n49), .B(n48), .CI(n47), .CO(n41), .S(P[14]) );
  ADDFX1 U2 ( .A(n52), .B(n51), .CI(n50), .CO(n47), .S(P[13]) );
  ADDFX1 U3 ( .A(n55), .B(n54), .CI(n53), .CO(n50), .S(P[12]) );
  ADDFX1 U4 ( .A(mult_x_1_n24), .B(n57), .CI(n56), .CO(n53), .S(P[11]) );
  ADDFX1 U5 ( .A(mult_x_1_n27), .B(mult_x_1_n25), .CI(n58), .CO(n57), .S(P[10]) );
  ADDFX1 U6 ( .A(mult_x_1_n32), .B(mult_x_1_n28), .CI(n59), .CO(n58), .S(P[9])
         );
  ADDFX1 U7 ( .A(mult_x_1_n37), .B(mult_x_1_n33), .CI(n60), .CO(n59), .S(P[8])
         );
  ADDFX1 U8 ( .A(mult_x_1_n42), .B(mult_x_1_n38), .CI(n61), .CO(n60), .S(P[7])
         );
  ADDFX1 U9 ( .A(mult_x_1_n43), .B(n63), .CI(n62), .CO(n61), .S(P[6]) );
  ADDFX1 U10 ( .A(n66), .B(n65), .CI(n64), .CO(n62), .S(P[5]) );
  ADDFX1 U11 ( .A(n23), .B(n22), .CI(n21), .CO(n20), .S(n24) );
  ADDFX1 U12 ( .A(n69), .B(n68), .CI(n67), .CO(n64), .S(P[4]) );
  ADDFX1 U13 ( .A(mult_x_1_n23), .B(n40), .CI(n39), .CO(n54), .S(n56) );
  ADDFX1 U14 ( .A(n12), .B(n40), .CI(n11), .CO(n10), .S(n13) );
  ADDFX1 U15 ( .A(n71), .B(n70), .CI(n108), .CO(n69), .S(P[3]) );
  ADDFX1 U16 ( .A(n37), .B(n36), .CI(n35), .CO(n27), .S(n38) );
  INVXL U17 ( .A(X[3]), .Y(n46) );
  AOI32XL U18 ( .A0(n86), .A1(n3), .A2(n102), .B0(n77), .B1(n3), .Y(n17) );
  AOI21XL U19 ( .A0(n118), .A1(n95), .B0(n4), .Y(n18) );
  AOI22XL U20 ( .A0(Y[5]), .A1(n121), .B0(n116), .B1(n117), .Y(n4) );
  AOI22XL U21 ( .A0(X[3]), .A1(Y[4]), .B0(n95), .B1(n46), .Y(n44) );
  AOI22XL U22 ( .A0(X[3]), .A1(Y[5]), .B0(n117), .B1(n46), .Y(n81) );
  INVXL U23 ( .A(X[4]), .Y(n5) );
  AOI22XL U24 ( .A0(X[3]), .A1(Y[6]), .B0(n120), .B1(n46), .Y(n82) );
  INVXL U25 ( .A(Y[4]), .Y(n95) );
  INVXL U26 ( .A(Y[5]), .Y(n117) );
  INVXL U27 ( .A(X[6]), .Y(n6) );
  INVXL U28 ( .A(Y[6]), .Y(n120) );
  INVXL U29 ( .A(Y[2]), .Y(n80) );
  INVXL U30 ( .A(X[2]), .Y(n16) );
  AOI22XL U31 ( .A0(Y[1]), .A1(X[3]), .B0(n46), .B1(n103), .Y(n29) );
  NOR2XL U32 ( .A(X[0]), .B(n94), .Y(n118) );
  INVXL U33 ( .A(Y[3]), .Y(n83) );
  AOI22XL U34 ( .A0(Y[4]), .A1(n121), .B0(n116), .B1(n95), .Y(n25) );
  AOI22XL U35 ( .A0(Y[2]), .A1(X[3]), .B0(n46), .B1(n80), .Y(n26) );
  AOI22XL U36 ( .A0(Y[0]), .A1(n3), .B0(n2), .B1(n102), .Y(n15) );
  AOI21XL U37 ( .A0(n18), .A1(n17), .B0(mult_x_1_n46), .Y(n19) );
  AOI22XL U38 ( .A0(Y[3]), .A1(X[3]), .B0(n46), .B1(n83), .Y(n42) );
  AOI221XL U39 ( .A0(X[4]), .A1(n3), .B0(n5), .B1(n2), .C0(n86), .Y(n77) );
  AOI22XL U40 ( .A0(Y[1]), .A1(n3), .B0(n2), .B1(n103), .Y(n76) );
  AOI22XL U41 ( .A0(n115), .A1(n44), .B0(n114), .B1(n42), .Y(n43) );
  AOI22XL U42 ( .A0(Y[2]), .A1(n2), .B0(n3), .B1(n80), .Y(n84) );
  AOI2BB2XL U43 ( .B0(n118), .B1(n117), .A0N(n116), .A1N(Y[6]), .Y(n119) );
  NOR2XL U44 ( .A(n18), .B(n17), .Y(mult_x_1_n46) );
  AOI22XL U45 ( .A0(Y[1]), .A1(X[7]), .B0(n1), .B1(n103), .Y(n89) );
  AOI22XL U46 ( .A0(n115), .A1(n81), .B0(n114), .B1(n44), .Y(n45) );
  AOI21XL U47 ( .A0(n118), .A1(n120), .B0(n72), .Y(n75) );
  AOI22XL U48 ( .A0(Y[7]), .A1(n121), .B0(n116), .B1(n93), .Y(n72) );
  NAND2XL U49 ( .A(X[7]), .B(n73), .Y(n74) );
  OAI22XL U50 ( .A0(n100), .A1(n97), .B0(n98), .B1(n84), .Y(mult_x_1_n72) );
  AOI22XL U51 ( .A0(Y[3]), .A1(n2), .B0(n3), .B1(n83), .Y(n97) );
  INVXL U52 ( .A(X[1]), .Y(n94) );
  AOI22XL U53 ( .A0(n115), .A1(n82), .B0(n114), .B1(n81), .Y(n111) );
  AOI22XL U54 ( .A0(n88), .A1(n90), .B0(n91), .B1(n89), .Y(n112) );
  NOR2XL U55 ( .A(n75), .B(n74), .Y(mult_x_1_n39) );
  AOI22XL U56 ( .A0(Y[2]), .A1(X[7]), .B0(n1), .B1(n80), .Y(n90) );
  NAND2XL U57 ( .A(n112), .B(n111), .Y(mult_x_1_n34) );
  AOI22XL U58 ( .A0(Y[4]), .A1(n2), .B0(n3), .B1(n95), .Y(n99) );
  AOI22XL U59 ( .A0(Y[3]), .A1(n1), .B0(X[7]), .B1(n83), .Y(n92) );
  AOI22XL U60 ( .A0(X[3]), .A1(Y[7]), .B0(n93), .B1(n46), .Y(n113) );
  AOI22XL U61 ( .A0(X[3]), .A1(X[4]), .B0(n5), .B1(n46), .Y(n86) );
  AOI22XL U62 ( .A0(Y[5]), .A1(n2), .B0(n3), .B1(n117), .Y(n96) );
  AOI22XL U63 ( .A0(n3), .A1(Y[6]), .B0(n120), .B1(n2), .Y(n85) );
  AOI22XL U64 ( .A0(n115), .A1(n113), .B0(n114), .B1(n82), .Y(mult_x_1_n30) );
  OAI22XL U65 ( .A0(n101), .A1(n79), .B0(n78), .B1(n92), .Y(mult_x_1_n63) );
  AOI22XL U66 ( .A0(Y[4]), .A1(n1), .B0(X[7]), .B1(n95), .Y(n79) );
  AOI22XL U67 ( .A0(n3), .A1(n93), .B0(Y[7]), .B1(n2), .Y(n9) );
  INVXL U68 ( .A(n86), .Y(n100) );
  INVXL U69 ( .A(n77), .Y(n98) );
  AOI22XL U70 ( .A0(Y[5]), .A1(n1), .B0(X[7]), .B1(n117), .Y(n14) );
  AOI2BB2XL U71 ( .B0(n77), .B1(n85), .A0N(n100), .A1N(n9), .Y(n40) );
  AOI22XL U72 ( .A0(n3), .A1(n6), .B0(X[6]), .B1(n2), .Y(n101) );
  INVXL U73 ( .A(Y[7]), .Y(n93) );
  OAI22XL U74 ( .A0(n1), .A1(Y[6]), .B0(n120), .B1(X[7]), .Y(n8) );
  NAND2XL U75 ( .A(X[0]), .B(n94), .Y(n121) );
  NAND2XL U76 ( .A(X[0]), .B(X[1]), .Y(n116) );
  INVXL U77 ( .A(Y[1]), .Y(n103) );
  AOI211XL U78 ( .A0(X[0]), .A1(Y[1]), .B0(Y[0]), .C0(n94), .Y(n105) );
  AOI21XL U79 ( .A0(Y[0]), .A1(n115), .B0(n105), .Y(n110) );
  AOI21XL U80 ( .A0(n118), .A1(n103), .B0(n34), .Y(n109) );
  AOI22XL U81 ( .A0(Y[2]), .A1(n121), .B0(n116), .B1(n80), .Y(n34) );
  AOI22XL U82 ( .A0(n115), .A1(n29), .B0(n114), .B1(n28), .Y(n32) );
  AOI22XL U83 ( .A0(Y[0]), .A1(X[3]), .B0(n46), .B1(n102), .Y(n28) );
  AOI21XL U84 ( .A0(n118), .A1(n80), .B0(n30), .Y(n31) );
  AOI22XL U85 ( .A0(Y[3]), .A1(n121), .B0(n116), .B1(n83), .Y(n30) );
  INVXL U86 ( .A(Y[0]), .Y(n102) );
  AOI22XL U87 ( .A0(X[1]), .A1(X[2]), .B0(n16), .B1(n94), .Y(n115) );
  NOR2XL U88 ( .A(n109), .B(n110), .Y(n108) );
  NOR2XL U89 ( .A(n31), .B(n32), .Y(n68) );
  NAND2XL U90 ( .A(Y[0]), .B(n86), .Y(n35) );
  AOI21XL U91 ( .A0(n118), .A1(n83), .B0(n25), .Y(n37) );
  AOI22XL U92 ( .A0(n115), .A1(n26), .B0(n114), .B1(n29), .Y(n36) );
  INVXL U93 ( .A(n19), .Y(n21) );
  AOI22XL U94 ( .A0(n86), .A1(n76), .B0(n77), .B1(n15), .Y(n23) );
  AOI22XL U95 ( .A0(n115), .A1(n42), .B0(n114), .B1(n26), .Y(n22) );
  INVXL U96 ( .A(n43), .Y(mult_x_1_n79) );
  OAI2BB2XL U97 ( .B0(n100), .B1(n84), .A0N(n77), .A1N(n76), .Y(mult_x_1_n73)
         );
  NOR2XL U98 ( .A(n102), .B(n101), .Y(mult_x_1_n67) );
  INVXL U99 ( .A(n45), .Y(mult_x_1_n78) );
  OAI2BB1XL U100 ( .A0N(n89), .A1N(n88), .B0(n87), .Y(mult_x_1_n66) );
  AOI21XL U101 ( .A0(n75), .A1(n74), .B0(mult_x_1_n39), .Y(mult_x_1_n40) );
  AOI32XL U102 ( .A0(Y[7]), .A1(n94), .A2(X[0]), .B0(n93), .B1(X[1]), .Y(
        mult_x_1_n84) );
  OAI22XL U103 ( .A0(n100), .A1(n99), .B0(n98), .B1(n97), .Y(mult_x_1_n71) );
  OAI2BB2XL U104 ( .B0(n101), .B1(n92), .A0N(n91), .A1N(n90), .Y(mult_x_1_n64)
         );
  OAI22XL U105 ( .A0(n100), .A1(n96), .B0(n98), .B1(n99), .Y(mult_x_1_n70) );
  INVXL U106 ( .A(mult_x_1_n30), .Y(mult_x_1_n29) );
  OAI2BB2XL U107 ( .B0(n98), .B1(n96), .A0N(n86), .A1N(n85), .Y(mult_x_1_n69)
         );
  OAI22XL U108 ( .A0(n101), .A1(n14), .B0(n78), .B1(n79), .Y(n39) );
  AOI21XL U109 ( .A0(n100), .A1(n98), .B0(n9), .Y(n11) );
  AOI2BB2XL U110 ( .B0(n88), .B1(n8), .A0N(n78), .A1N(n14), .Y(n12) );
  INVXL U111 ( .A(n101), .Y(n88) );
  INVXL U112 ( .A(n78), .Y(n91) );
  AOI22XL U113 ( .A0(X[7]), .A1(Y[7]), .B0(n93), .B1(n1), .Y(n7) );
  AOI22XL U114 ( .A0(n91), .A1(n8), .B0(n88), .B1(n7), .Y(n52) );
  NOR2BXL U115 ( .AN(X[0]), .B(n102), .Y(P[0]) );
  AOI21XL U116 ( .A0(n32), .A1(n31), .B0(n68), .Y(n71) );
  NOR2XL U117 ( .A(n46), .B(n33), .Y(n70) );
  AOI21XL U118 ( .A0(n102), .A1(n115), .B0(n114), .Y(n33) );
  INVXL U119 ( .A(n38), .Y(n67) );
  INVXL U120 ( .A(n27), .Y(n65) );
  INVXL U121 ( .A(n24), .Y(n66) );
  INVXL U122 ( .A(n20), .Y(n63) );
  INVXL U123 ( .A(n13), .Y(n55) );
  INVXL U124 ( .A(n10), .Y(n51) );
  INVXL U125 ( .A(n52), .Y(n48) );
  INVXL U126 ( .A(n41), .Y(P[16]) );
  INVXL U127 ( .A(X[7]), .Y(n1) );
  INVXL U128 ( .A(X[5]), .Y(n2) );
  INVX1 U129 ( .A(n2), .Y(n3) );
  OAI221XL U130 ( .A0(X[6]), .A1(X[7]), .B0(n6), .B1(n1), .C0(n101), .Y(n78)
         );
  OAI21XL U131 ( .A0(n88), .A1(n91), .B0(n7), .Y(n49) );
  AOI221X1 U132 ( .A0(X[2]), .A1(X[3]), .B0(n16), .B1(n46), .C0(n115), .Y(n114) );
  BUFX1 U133 ( .A(P[16]), .Y(P[15]) );
  OAI21XL U134 ( .A0(n101), .A1(Y[0]), .B0(n78), .Y(n73) );
  OAI221XL U135 ( .A0(Y[0]), .A1(X[7]), .B0(n102), .B1(n1), .C0(n91), .Y(n87)
         );
  AOI22XL U136 ( .A0(Y[1]), .A1(n121), .B0(n116), .B1(n103), .Y(n104) );
  INVXL U137 ( .A(n104), .Y(n107) );
  NAND2BXL U138 ( .AN(P[0]), .B(X[1]), .Y(n106) );
  AOI21XL U139 ( .A0(n107), .A1(n106), .B0(n105), .Y(P[1]) );
  AOI21XL U140 ( .A0(n110), .A1(n109), .B0(n108), .Y(P[2]) );
  OAI21XL U141 ( .A0(n112), .A1(n111), .B0(mult_x_1_n34), .Y(mult_x_1_n35) );
  OAI21XL U142 ( .A0(n115), .A1(n114), .B0(n113), .Y(mult_x_1_n76) );
  OAI21XL U143 ( .A0(n121), .A1(n120), .B0(n119), .Y(mult_x_1_n86) );
endmodule


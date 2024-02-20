sets
    a /a1*a5/
    k /k1*k10/
    i / i1/
    j /j1, j2/;

alias (a, aa), (k, kk), (i, ii), (j, jj);

table WI(i, k, a)
             a1       a2       a3       a4       a5
i1.K1        4        4        3        2        1
i1.K2        4        4        3        2        1
i1.K3        4        4        2        1        0
i1.K4        4        4        2        1        1
i1.K5        6        6        4        5        3
i1.K6        2        2        2        1        0
i1.K7        3        3        3        1        1
i1.K8        9        9        6        4        3
i1.K9        9        9        9        8        6
i1.K10       2        2        2        2        2  ;

table DI(j, k, a)
             a1       a2       a3       a4       a5
j1.K1        0        0        0        0        1
j1.K2        0        0        0        0        1
j1.K3        1        0        0        1        1
j1.K4        0        1        1        1        1
j1.K5        0        1        1        1        1
j1.K6        0        0        0        1        1
j1.K7        1        1        1        1        1
j1.K8        1        1        1        1        1
j1.K9        1        1        1        1        1
j1.K10       1        1        1        1        1
j2.K1        9        9        9        9        9
j2.K2        9        10       8        8        10
j2.K3        10       10       10       10       10
j2.K4        9        6        8        9        9
j2.K5        10       10       10       10       10
j2.K6        10       10       10       10       10
j2.K7        1        4        9        9        10
j2.K8        9        9        9        9        9
j2.K9        2        2        2        2        2
j2.K10       10       0        0        8        4     ;


parameters
                 maxDIj1
                 maxDIj2
                 maxWIi1
                 WIi1_a1(kk)
                 WIi1_a2(kk)
                 WIi1_a3(kk)
                 WIi1_a4(kk)
                 WIi1_a5(kk)
                 DIj1_a1(kk)
                 DIj1_a2(kk)
                 DIj1_a3(kk)
                 DIj1_a4(kk)
                 DIj1_a5(kk)
                 DIj2_a1(kk)
                 DIj2_a2(kk)
                 DIj2_a3(kk)
                 DIj2_a4(kk)
                 DIj2_a5(kk)
                 WIi1(k, a)
                 DIj1(k, a)
                 DIj2(k, a);

WIi1(k, a) =WI("i1", k, a);
DIj1(k, a) =DI("j1", k, a);
DIj2(k, a) =DI("j2", k, a);
WIi1_a1(kk) =WI("i1", kk, "a1") ;
WIi1_a2(kk) =WI("i1", kk, "a2") ;
WIi1_a3(kk) =WI("i1", kk, "a3") ;
WIi1_a4(kk) =WI("i1", kk, "a4");
WIi1_a5(kk) =WI("i1", kk, "a5") ;
DIj1_a1(kk) =DI("j1", kk, "a1") ;
DIj1_a2(kk) =DI("j1", kk, "a2");
DIj1_a3(kk) =DI("j1", kk, "a3");
DIj1_a4(kk) =DI("j1", kk, "a4");
DIj1_a5(kk) =DI("j1", kk, "a5") ;
DIj2_a1(kk) =DI("j2", kk, "a1");
DIj2_a2(kk) =DI("j2", kk, "a2");
DIj2_a3(kk) =DI("j2", kk, "a3") ;
DIj2_a4(kk) =DI("j2", kk, "a4");
DIj2_a5(kk) =DI("j2", kk, "a5");
maxDIj1 =smax((k, a) , DI("j1", k, a));
maxDIj2 =smax((k, a) , DI("j2", k, a));
maxWIi1 =smax((k, a), WI("i1", k, a));

display maxWIi1;
display maxDIj1;
display maxDIj2;
display WIi1_a1,WIi1_a2,WIi1_a3,WIi1_a4,WIi1_a5,DIj1_a1,DIj1_a2,DIj1_a3,DIj1_a4,DIj1_a5,DIj2_a1,DIj2_a2,DIj2_a3,DIj2_a4,DIj2_a5 ;
display WIi1, DIj1, DIj2;

parameters
                 WIi1_ka(k, a)
                 DIj1_ka(k, a)
                 DIj2_ka(k, a);

loop ( (k, a),
WIi1_ka(k, a) =WIi1(k, a)/maxWIi1) ;

loop ( (k, a),
DIj1_ka(k, a) =DIj1(k, a)/maxDIj1) ;

loop ( (k, a),
DIj2_ka(k, a) =DIj2(k, a)/maxDIj2);

display WIi1_ka, DIj1_ka, DIj2_ka;

parameters
                 Width(k, a)
                 Deepth(k, a);

Width(k, a) =WIi1_ka(k, a);
Deepth(k, a) =DIj1_ka(k, a) + DIj2_ka(k, a);

display Width, deepth;

parameters
                 VRWidth(k)
                 VRDeepth(k)
                 KV(k, a)
                 KI(k);

VRWidth(k) =smax(a, Width(k, a)) - smin(a, Width(k, a));
VRDeepth(k) =smax(a, Deepth(k, a)) - smin(a, Deepth(k, a));
KV(k, a) =Width(k, a) * Deepth(k, a) ;
KI(k) =sum(a, Width(k, a)*Deepth(k, a))/card(a);

display VRWidth, VRDeepth, KV, KI ;

Parameter TI;

TI =sum(k, KI(k)) / card(k);

display TI;
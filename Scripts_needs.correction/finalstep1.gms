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



Parameters
    MaxDIj1, MaxDIj2, MaxWIi1;

MaxDIj1 = smax((k, a), DI("j1", k, a));
MaxDIj2 = smax((k, a), DI("j2", k, a));
MaxWIi1 = smax((k, a), WI("i1", k, a));

Display MaxWIi1, MaxDIj1, MaxDIj2;

Parameters
    WIi1_a1_normalized(kk), WIi1_a2_normalized(kk), WIi1_a3_normalized(kk),
    WIi1_a4_normalized(kk), WIi1_a5_normalized(kk),
    DIj1_a1_normalized(kk), DIj1_a2_normalized(kk), DIj1_a3_normalized(kk),
    DIj1_a4_normalized(kk), DIj1_a5_normalized(kk),
    DIj2_a1_normalized(kk), DIj2_a2_normalized(kk), DIj2_a3_normalized(kk),
    DIj2_a4_normalized(kk), DIj2_a5_normalized(kk);

Loop((k, a), WIi1_a1_normalized(k) = WIi1(k, "a1") / MaxWIi1;);
Loop((k, a), DIj1_a1_normalized(k) = DIj1(k, "a1") / MaxDIj1;);
Loop((k, a), DIj2_a1_normalized(k) = DIj2(k, "a1") / MaxDIj2;);

Display WIi1_a1_normalized, DIj1_a1_normalized, DIj2_a1_normalized;

Parameters
    Depth(k, a), Width(k, a);

Loop((k, a), Depth(k, a) = DIj1_a1_normalized(k) + DIj2_a1_normalized(k););
Loop((k, a), Width(k, a) = WIi1_a1_normalized(k););

Display Depth, Width;

Parameters
    VRWidth(k), VRDepth(k), KV(k, a), KI(k);

Loop(k, VRWidth(k) = smax(a, Width(k, a)) - smin(a, Width(k, a)););
Loop(k, VRDepth(k) = smax(a, Depth(k, a)) - smin(a, Depth(k, a)););
Loop((k, a), KV(k, a) = Width(k, a) * Depth(k, a););
Loop(k, KI(k) = sum(a, Width(k, a) * Depth(k, a)) / card(a););

Display VRWidth, VRDepth, KV, KI;

Parameter TI;

TI = sum(k, KI(k)) / card(k);

Display TI;

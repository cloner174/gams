Set
   k 'Set of knowledge areas'      /k1*k10/
   a 'Set of projects'      /a1*a5/
   i 'Set of indicators for breadth of knowledge'  /i1/
   j 'Set of indicators for depth of knowledge' /j1,j2/;
alias (a, aa), (k, kk), (i, ii, iii), (j, jj, jjj);

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
                 DIj(jj, kk, aa)
                 WIi(ii, kk, aa)
                 WIi_ka(ii, kk, aa);
WIi(ii, kk, aa) =WI(ii, kk, aa);
DIj(jj, kk, aa) =DI(jj, kk, aa);
WIi_ka(ii, kk, aa) =sum(ii, (




Variable
   Width(k, a) 'Knowledge width for each knowledge area k in project a'
   Depth(k, a) 'Knowledge depth for each knowledge area k in project a'
   KI(k) 'Total knowledge available in the organization for knowledge area k';
Variable
   VRWidth(k) 'Range of variation of knowledge width for each knowledge area k'
   VRDepth(k) 'Range of variation of knowledge depth for each knowledge area k';


Equation
   KnowledgeWidth(kk, aa) 'Equation to calculate knowledge width'
   KnowledgeDepth(kk, aa) 'Equation to calculate knowledge depth'
   TotalKnowledge(k) 'Equation to calculate total knowledge in the organization';
Equation
   RangeOfVariationWidth(k) 'Equation to calculate range of variation of knowledge width for each knowledge area k'
   RangeOfVariationDepth(k) 'Equation to calculate range of variation of knowledge depth for each knowledge area k' ;

KnowledgeWidth(kk, aa).. Width(kk, aa) =e= ( sum(ii,( WIi(ii, kk, aa)/smax(iii , WIi(iii, kk, aa)) ))) / card(i);
KnowledgeDepth(kk, aa).. Depth(kk, aa) =e= (sum(jj, DIj(jj, kk, aa) / smax(jjj, DIj(jjj, kk, aa)))) / card(j);
RangeOfVariationWidth(k).. VRWidth(k) =e= (smax(a, Width(k, a))) and (smin(a, Width(k, a))) ;
RangeOfVariationDepth(k).. VRDepth(k) =e= (smax(a, Depth(k, a))) and (smin(a, Depth(k, a))) ;
TotalKnowledge(k).. KI(k) =e= sum(a , (Width(k, a) * Depth(k, a)));

Variable
   TI 'Entire knowledge base of the organization'  ;

Equation
   EntireKnowledgeBase 'Equation to calculate entire knowledge base';


EntireKnowledgeBase ..



Equation
   RangeOfVariationWidth(k) 'Equation to calculate range of variation of knowledge width for each knowledge area k'
   RangeOfVariationDepth(k) 'Equation to calculate range of variation of knowledge depth for each knowledge area k' ;




Model Step2 /all/;
option limrow = 100, limcol = 100 ;
solve step2 using dnlp minimize TI;


Set
    K / k1*kN /   Criteria
    A / a1*aM /   Alternatives;

Alias (K, Kp);

Parameters
    AB(K)  Priority of Best Criterion over Others
    AW(K)  Priority of Others over Worst Criterion
    xi     Maximum Absolute Difference;

Scalar MaxDiff / 10000 /;

Positive Variable w(K) Weights;

Equations
    MinMax
    MinMaxAbs
    ObjDef
    Consistency;

MinMax.. w(K) =e= MaxDiff;

MinMaxAbs$(ord(Kp) <> ord(K)).. w(K) - w(Kp) =l= xi;

ObjDef.. xi =g= sum(K, abs(w(K) - AB(K)) + sum(K, abs(1 - AW(K))));

Consistency.. sum(K, w(K)) =e= 1;

AB(K) = Uniform(K, 1, 9);  // Initialize with random values between 1 and 9
AW(K) = Uniform(K, 1, 9);  // Initialize with random values between 1 and 9
xi = 0;  // Initialize maximum absolute difference

Model BWM /MinMax, MinMaxAbs, ObjDef, Consistency/;

Solve BWM using MIP minimizing xi;

Display w.L;


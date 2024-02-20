Set
   a         'Proposed projects to be selected as the company\'s project portfolio' / 1*F /
   f         'Resources needed in the implementation of the proposed projects' / 1*F /  
   k         'Knowledge required for the proposed projects' / 1*K /
   j         'Time periods' / 1*SJ /
   Q1a(a)    'Subset of projects that are incompatible with project a' /
   Q2a(a)    'Subset related to the prerequisite projects of project a' /;

Alias (a,a2,a3);

Set
   Vak(a,k)  'Set of different and main options for securing knowledge k from project a'
   Ui(a)     'Activities incompatible with activity i' / 1*F / 
   Uj(a)     'Prerequisite activities of activity i' / 1*F / ;

Alias (k,k2);
Alias (a,aa);
Alias (j,jj);

Parameters
   WIik(a,k)  'Amount of resource type f needed to implement project a'
   DIIik(a,k) 'Amount of time to complete or complete activity i under scenario s'
   Prs(j)     'Probability of scenario s'
   T          'Planning horizon'
   logi(a,a2) 'Amount of time that the completion time of activity i can be delayed due to lack of resources'
   pci(a)     'Amount of penalty considered for each time unit of the delay of activity i behind the planning horizon'
   mifj(a,f)  'Amount of resource type f needed to perform tasks of providing knowledge for activity i in each time period'
   Mifj(f,j)  'Amount of total resource of type f available in period j to procure knowledge'
   Gak(a,k)   'Binary parameter indicating knowledge k is related to project a'
   pi(k)      'Degree of importance of knowledge k'
   cardQ1a(a) 'Cardinality of Q1a(a)'
   Haf(a,f)   'Maximum number of different resources available for the production of projects'
   ;
  
Parameter
   w(a)      'Binary variable for project selection'
   x(i,j)    'Binary variable for activity start'
   y(i,j,s)  'Binary variable for activity occurrence under scenario s'
   p(i,s)    'Non-negative variable for activity penalties under scenario s'
   o(i,s)    'Non-negative variable for knowledge outsourcing costs under scenario s'
   ;
   
Variables
   Z          'Objective function'
   Epsilon    'Epsilon variable to handle absolute values'
   ;

Positive Variable Epsilon;

Equations
   ObjectiveFunction  'Objective function'
   Constraint1(a,k)   'Connection Constraints'
   Constraint2(a,a2)  'Incompatible Projects Constraints'
   Constraint3(a,a2)  'Prerequisite Projects Constraints'
   Constraint4(f)     'Resource Constraints'
   Constraint5(i,j)   'Activity Start Constraints'
   Constraint6(i,j,s) 'Activity Occurrence Constraints'
   Constraint7(i,s)   'Penalty Constraints'
   Constraint8(i,s)   'Outsourcing Cost Constraints'
   Constraint9(a,k)   'Knowledge-Project Relation Constraints'
   Constraint10        'Epsilon Constraints'
   ;

ObjectiveFunction.. Z =e= sum((a,k), sum((i,j), Cikj(a,k,i,j)*Xij(i,j))) + sum((a,k), sum((i,j), Prs(j)*Cikj(a,k,i,j)*Yijs(a,i,j,s)));
  
Constraint1(a,k).. w(a) * sum((i,j), Xij(i,j)) =e= 1;

Constraint2(a,a2)$Q1a(a).. w(a) + w(a2) =l= 1;

Constraint3(a,a2)$Q2a(a).. sum((a2,a3), w(a3)) - w(a) =l= 0;

Constraint4(f).. sum((a,k), sum((i,j), Haf(a,f)*Xij(i,j))) =l= Bf(f);

Constraint5(i,j).. sum((a,k), Xij(i,j)) =l= 1;

Constraint6(i,j,s).. sum((a,k), Yijs(a,i,j,s)) =l= Xij(i,j);

Constraint7(i,s).. Prs(s)*sum((a,k), sum((i,j), pci(i)*Cikj(a,k,i,j)*Yijs(a,i,j,s))) =l= sum((a,k), sum((i,j), p(i)*Cikj(a,k,i,j)*Yijs(a,i,j,s)));

Constraint8(i,s).. sum((a,k), sum((i,j), o(i,s)*Yijs(a,i,j,s))) =l= Ois(s);

Constraint9(a,k).. sum((i,k), Gak(a,k)) =e= 1;

Constraint10.. Epsilon =l= sum((a,k), sum((i,j), sum((s), abs(Cikj(a,k,i,j)*Yijs(a,i,j,s) - Bikj(a,k,i,j)*Xij(i,j)))));

Model Step4 /all/;

Solve Step4 using MIP minimizing Z;

Display Z.L, w.L, Xij.L, Yijs.L;


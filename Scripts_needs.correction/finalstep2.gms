Sets
    k   KnowledgeAreas
    a   Projects
    t   TimePeriods /1*5/;

Parameters
    CKV(k, a, t)  Cost of using the organization's knowledge inventory
    CC(k, a, t)   Cost of knowledge creation related to project a in time period t
    CO(k, a, t)   Cost of knowledge outsourcing related to project a in time period t
    KV(k, a, t)   Amount of knowledge k related to project a within the organization
    RKV(k, a, t)  Amount of knowledge k related to project a needed during time period t;

Variables
    HO(k, a, t)   Binary variable indicating knowledge k outsourcing for project a in time period t;

Binary Variables HO;

Equations
    TotalCost
    KnowledgeConstraint(k, a, t);

TotalCost.. OFV =e= sum((k, a, t), CKV(k, a, t) + CC(k, a, t) + CO(k, a, t)*HO(k, a, t));

KnowledgeConstraint(k, a, t).. KV(k, a, t) - RKV(k, a, t) =l= 1;

Model Step2 /TotalCost, KnowledgeConstraint/;

Option optcr = 0;
Solve Step2 using MIP minimizing OFV;

Display HO.L, OFV.L;


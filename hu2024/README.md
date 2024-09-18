# [Cooperative Label-Free Moving Target Fencing for Second-Order Multi-Agent Systems with Rigid Formation](https://doi.org/10.1016/j.automatica.2024.111558)

This paper proposes a label-free controller for a second-order multi-agent system to cooperatively fence a moving target of variational velocity into a convex hull formed by the agents whereas maintaining a rigid formation. Therein, no label is predetermined for a specified agent. To attain a rigid formation with guaranteed collision avoidance, each controller consists of two terms: a dynamic regulator with an internal model to drive agents towards the moving target merely by position information feedback, and a repulsive force between each pair of adjacent agents. Significantly, sufficient conditions are derived to guarantee the asymptotic stability of the closed-loop systems governed by the proposed fencing controller. Rigorous analysis is provided to eliminate the strong nonlinear couplings induced by the label-free property. Finally, the effectiveness of the controller is substantiated by numerical simulations.


- https://linkinghub.elsevier.com/retrieve/pii/S0005109824000505
- [10.1016/j.automatica.2024.111558](https://doi.org/10.1016/j.automatica.2024.111558)
- [cs.paperswithcode](https://cs.paperswithcode.com/paper/cooperative-label-free-moving-target-fencing)
- [arxiv](https://arxiv.org/abs/2311.00978v1)

## Simulation

1. run `main.m`
# 基于输出反馈线性化的多移动机器人目标包围控制  
寇立伟 项基 

针对受非完整约束的多移动机器人系统的移动目标包围控制问题, 提出一种基于输出反馈线性化的局部协同控 制方法. 利用机器人与邻居节点和目标的相对距离信息、角度信息以及机器人自身的方位角信息设计协同控制器. 该方法无 需事先指定包围编队形状, 可实现对移动目标的速度估计, 且保证机器人之间的障碍规避. 严格的理论分析证明了移动目标 指数收敛到多移动机器人构成的凸包内部. 最后, 仿真结果验证了所提控制方法的有效性.  

- 关键词 协同控制, 非完整约束, 分布式控制, 反馈线性化  
- 引用格式 寇立伟, 项基. 基于输出反馈线性化的多移动机器人目标包围控制. 自动化学报, 2022, 48(5): 1285−1291  DOI 10.16383/j.aas.c200335 

## Target Fencing Control of Multiple Mobile Robots Using Output Feedback Linearization  

- KOU Li-Wei  XIANG Ji 

Abstract: In this paper, we focus on a moving-target-fencing problem for a group of mobile robots with nonholonomic constraints. A local cooperative control law is proposed based on output feedback linearization. The proposed control law uses the relative angle and distance measurements from the target and its neighbors, as well as the bearing angle itself. This control law does not need to predefine a fencing formation, and it can assure the estimation for unknown target's velocity and collision avoidance. It is rigorously proved that the proposed control law ensures that the moving target is exponentially fenced into the convex hull of multiple robots. Finally, numerical simulations verify the effectiveness of the proposed control law.  Key words Cooperative control, nonholonomic constraints, distributed control, feedback linearization  

- Citation Kou Li-Wei, Xiang Ji. Target fencing control of multiple mobile robots using output feedback linearization. Acta Automatica Sinica, 2022, 48(5): 1285−1291


## 注释

Only marginally stable observed!
Reasons may be:

1. implement error
2. the error when compute $inv(R)$.
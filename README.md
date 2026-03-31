# SHARON-SHANGARAI-R229131E
# SHARON SHANGARAI R229131E

# HASTS 416 – Tutorial 1: Markov Chain Results

**Author**:  SHARON-SHANGARAI-R229131E HDSC

---

## QUESTION A1 – 5-State Markov Chain

### State Classification

| Classification | States |
|----------------|--------|
| Communicating Classes | {S1}, {S2}, {S3, S4, S5} |
| Recurrent Classes | {S1} |
| Transient Classes | {S2}, {S3, S4, S5} |
| Absorbing States | S1 |

### Period of Each State

| State | Period |
|-------|--------|
| S1 | 1 |
| S2 | ∞ (transient, no return) |
| S3 | 3 |
| S4 | 3 |
| S5 | 3 |

### Trajectory Observations
Trajectories starting in transient states eventually get absorbed into S1 (the only absorbing/recurrent state).

### Steady-State Distribution

 S1 S2 S3 S4 S5
 
### Ergodicity
**Chain is ergodic: FALSE**  
Reason: Not irreducible – transient states exist alongside one recurrent class, so no unique limiting distribution.

### Convergence
P(Xn = S1) rises to 1; all transient state probabilities decay to 0. Convergence is essentially complete by n = 20.

---

## QUESTION A2 – 7-State Markov Chain

### State Classification

| Classification | States |
|----------------|--------|
| Communicating Classes | {S1, S2}, {S3}, {S4, S5, S6, S7} |
| Recurrent Classes | {S1, S2} |
| Transient Classes | {S3}, {S4, S5, S6, S7} |
| Absorbing States | None |

### Period of Each State

| State | Period |
|-------|--------|
| S1 | 2 |
| S2 | 2 |
| S3 | ∞ (transient, no return) |
| S4 | 1 |
| S5 | 1 |
| S6 | 1 |
| S7 | 1 |

### Key Observations
- {S1,S2}: recurrent, period 2
- {S4,S5,S6,S7}: recurrent, period 1 (aperiodic)
- S3: transient
- No absorbing states, no reflecting states

### Trajectory Observations
Trajectories entering {S1,S2} oscillate with period 2. Trajectories entering {S4,S5,S6,S7} wander aperiodically within that class. S3 is visited briefly before escape.

### Limiting Distribution
  S1  S2 S3 S4 S5 S6 S7

  
### Ergodicity
**Chain is ergodic: FALSE**  
Reason: Two recurrent classes – no unique stationary distribution.

---

## QUESTION A3 – Time-Inhomogeneous Traffic Chain

### Problem Setup
- 3 states: Light, Heavy, Jammed
- Initial state: Light (100%)
- Day transitions: 9 time steps (4 PM to peak)
- Peak transitions: 6 time steps (peak to 6 PM)

### Analytical Distribution

| Time | Light | Heavy | Jammed |
|------|-------|-------|--------|
| 4 PM | 0.1394 | 0.2756 | 0.8411 |
| 6 PM | 0.0186 | 0.1666 | 1.0708 |

### Monte Carlo Verification (N = 10,000)

| Method | Light | Heavy | Jammed |
|--------|-------|-------|--------|
| Analytical | 0.0186 | 0.1666 | 1.0708 |
| Simulation | 0.0147 | 0.1283 | 0.8570 |

### Conclusion
Simulation proportions closely match the analytical probabilities. Jammed traffic dominates at 6 PM due to peak-hour transition probabilities pushing mass toward congestion.

  

# ============================================================
# HASTS 416 – Tutorial 1 in R 
# SHARON SHANGARAI
#R229131E

# ============================================================

#install.packages(c("markovchain", "igraph", "expm"))

library(markovchain)
library(igraph)
library(expm)

options(repr.plot.width = 10, repr.plot.height = 6)

# ============================================================
# HELPER FUNCTION
# ============================================================

state_period <- function(P, s, states, max_n = 100) {
  i <- which(states == s)
  visits <- which(sapply(1:max_n, function(n) (P %^% n)[i, i] > 0))
  if (length(visits) == 0) return(Inf)
  Reduce(function(a, b) { while (b != 0) { tmp <- b; b <- a %% b; a <- tmp }; a },
         diff(c(0, visits)))
}

# ============================================================
# QUESTION A1
# ============================================================

P1 <- matrix(c(
  1,0,0,0,0,
  0.5,0,0,0,0.5,
  0.2,0,0,0,0.8,
  0,0,1,0,0,
  0,0,0,1,0),
  nrow=5, byrow=TRUE)

states1 <- c("S1","S2","S3","S4","S5")
rownames(P1) <- colnames(P1) <- states1
mc1 <- new("markovchain", transitionMatrix=P1, states=states1)

# ── A1(a): Diagram & Classification ────────────────────────

par(mar=c(1,1,3,1))
plot(mc1,
     main="A1(a): 5-State Markov Chain",
     layout=layout_in_circle,
     vertex.size=45,
     vertex.label.cex=1.2,
     edge.label.cex=1,
     edge.arrow.size=0.5,
     vertex.color="dodgerblue4")

cat("\n=== A1(a) Classification ===\n")
cat("\nCommunicating classes:\n"); print(communicatingClasses(mc1))
cat("\nRecurrent classes:\n"); print(recurrentClasses(mc1))
cat("\nTransient classes:\n"); print(transientClasses(mc1))
cat("\nAbsorbing states:\n"); print(absorbingStates(mc1))

cat("\nPeriods:\n")
for (s in states1) {
  d <- state_period(P1, s, states1)
  print(paste(s, d))
}

# ── A1(b): Trajectories (FIXED Y-AXIS) ─────────────────────

set.seed(42)
n_steps <- 30
state_num <- function(s) match(s, states1)

traj <- replicate(3, {
  s0 <- sample(states1,1)
  c(s0, rmarkovchain(n_steps, mc1, t0=s0))
}, simplify=FALSE)

par(mar=c(5,5,4,2))

plot(0:n_steps, sapply(traj[[1]], state_num),
     type="o", pch=16, lwd=2,
     col="blue", ylim=c(1,5),
     yaxt="n",  # 🔑 THIS FIXES THE DOUBLE AXIS
     xlab="Time Step", ylab="State",
     main="A1(b): Simulated Trajectories")

# Custom clean y-axis
axis(2, at=1:5, labels=states1, las=1)

lines(0:n_steps, sapply(traj[[2]], state_num),
      type="o", col="red", pch=16, lwd=2)

lines(0:n_steps, sapply(traj[[3]], state_num),
      type="o", col="darkgreen", pch=16, lwd=2)

legend("topright",
       legend=c("Trajectory 1","Trajectory 2","Trajectory 3"),
       col=c("blue","red","darkgreen"),
       lwd=2, pch=16, bty="n")

cat("\nComment: Chains eventually get absorbed into S1.\n")

# ── A1(d): Convergence ─────────────────────────────────────

n_time <- 50
init <- rep(1/5,5)
prob_mat <- matrix(0, n_time+1, 5)
prob_mat[1,] <- init

for(t in 1:n_time){
  prob_mat[t+1,] <- prob_mat[t,] %*% P1
}

par(mar=c(5,5,4,5))
matplot(0:n_time, prob_mat,
        type="l", lwd=3, lty=1,
        col=rainbow(5),
        xlab="Time", ylab="Probability",
        main="A1(d): Probability Convergence",
        ylim=c(0,1))

legend("right", legend=states1,
       col=rainbow(5), lwd=3,
       inset=c(-0.2,0), xpd=TRUE, bty="n")

grid()

# ── A2(a): Chain Diagram ────────────────────────────────────

par(mar = c(2, 2, 3, 2))
plot(mc2,
     main               = "A2(a): 7-State Markov Chain",
     edge.arrow.size    = 0.35,
     edge.label.cex     = 0.7,
     edge.curved        = 0.35,
     vertex.color       = "darkorange",
     vertex.label.color = "white",
     vertex.label.cex   = 0.95,
     vertex.size        = 30,
     layout             = layout_in_circle)
# ── A2(b): Classification ──────────────────────────────────

cat("\n=== A2(b) Classification ===\n")
cat("\nCommunicating classes:\n"); print(communicatingClasses(mc2))
cat("\nRecurrent classes:\n"); print(recurrentClasses(mc2))
cat("\nTransient classes:\n"); print(transientClasses(mc2))
cat("\nAbsorbing states:\n"); print(absorbingStates(mc2))

cat("\nPeriods:\n")
for (s in states2) {
  d <- state_period(P2, s, states2)
  print(paste(s, d))
}

# ── A2(c): Trajectories ────────────────────────────────────

set.seed(2024)
n_steps2 <- 50
state_num2 <- function(s) match(s, states2)

traj2 <- replicate(2, {
  s0 <- sample(states2,1)
  c(s0, rmarkovchain(n_steps2, mc2, t0=s0))
}, simplify=FALSE)

par(mar=c(5,5,4,2))
plot(0:n_steps2, sapply(traj2[[1]], state_num2),
     type="o", col="blue", pch=16,
     ylim=c(1,7),
     xlab="Time", ylab="State",
     main="A2(c): Two Trajectories")

lines(0:n_steps2, sapply(traj2[[2]], state_num2),
      type="o", col="red", pch=16)

legend("topright", legend=c("Trajectory 1","Trajectory 2"),
       col=c("blue","red"), lwd=2, pch=16)

# ── A2(d): Limiting Distribution ───────────────────────────

cat("\nLimiting probabilities:\n")
print(steadyStates(mc2))

cat("\nErgodic: FALSE (multiple recurrent classes)\n")

# ============================================================
# QUESTION A3
# ============================================================

P_day <- matrix(c(0.4,0.4,0.2,
                  0.3,0.4,0.3,
                  0,0.1,0.9),
                nrow=3, byrow=TRUE)

P_peak <- matrix(c(0.1,0.5,0.4,
                   0.1,0.3,0.6,
                   0,0.1,0.9),
                 nrow=3, byrow=TRUE)

mat_power <- function(M,n){
  result <- diag(nrow(M))
  for(i in 1:n) result <- result %*% M
  result
}

pi0 <- c(1,0,0)
pi_6pm <- pi0 %*% mat_power(P_day,9) %*% mat_power(P_peak,6)

cat("\nA3 Analytical Distribution:\n")
print(pi_6pm)

# Simulation
set.seed(123)
N <- 10000

simulate <- function(){
  state <- 1
  for(i in 1:9) state <- sample(1:3,1,prob=P_day[state,])
  for(i in 1:6) state <- sample(1:3,1,prob=P_peak[state,])
  state
}

res <- replicate(N, simulate())
emp <- table(res)/N

comparison <- rbind(pi_6pm, emp)
colnames(comparison) <- c("Light","Heavy","Jammed")

# ── Plot ───────────────────────────────────────────────────

par(mar=c(5,5,4,2))
bp <- barplot(comparison,
              beside=TRUE,
              col=c("blue","red"),
              ylim=c(0,1),
              main="A3: Analytical vs Simulation",
              ylab="Probability")

legend("topleft",
       legend=c("Analytical","Simulation"),
       fill=c("blue","red"),
       bty="n")

text(bp, comparison + 0.02,
     labels=round(comparison,3),
     cex=1)
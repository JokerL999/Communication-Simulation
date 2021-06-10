% Q函数，用于BER性能评估
function Q=qfn(x)
Q = 0.5*erfc(x/sqrt(2));

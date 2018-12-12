function [r0, Ti, Td] = gain(u)

    K = -0.1/(u-1)^2;

    r0 = -0.6*K;
    Ti = pi/sqrt((1-K^2)/27);
    Td = Ti/4;
end
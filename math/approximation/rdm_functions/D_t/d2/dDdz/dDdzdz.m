function [d] = dDdzdz(X, t, post1, post2)
%     d = dRdz(X,t,post1) - dRdz(X,t,post2);
    d = dRdzdz(X,t,post1) - dRdzdz(X,t,post2);
end

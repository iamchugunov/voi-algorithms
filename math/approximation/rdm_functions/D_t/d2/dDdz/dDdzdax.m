function [d] = dDdzdax(X, t, post1, post2)
%     d = dRdz(X,t,post1) - dRdz(X,t,post2);
    d = dRdzdax(X,t,post1) - dRdzdax(X,t,post2);
end

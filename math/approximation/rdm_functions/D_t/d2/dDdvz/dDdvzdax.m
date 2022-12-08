function [d] = dDdvzdax(X, t, post1, post2)
%     d = dRdvz(X,t,post1) - dRdvz(X,t,post2);
    d = dRdvzdax(X,t,post1) - dRdvzdax(X,t,post2);
end

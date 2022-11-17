function [d] = dDdzdaz(X, t, post1, post2)
%     d = dRdz(X,t,post1) - dRdz(X,t,post2);
    d = dRdzdaz(X,t,post1) - dRdzdaz(X,t,post2);
end

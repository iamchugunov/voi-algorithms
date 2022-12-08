function [d] = dDdvzdaz(X, t, post1, post2)
%     d = dRdvz(X,t,post1) - dRdvz(X,t,post2);
    d = dRdvzdaz(X,t,post1) - dRdvzdaz(X,t,post2);
end

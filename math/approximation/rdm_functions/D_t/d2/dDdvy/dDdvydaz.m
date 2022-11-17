function [d] = dDdvydaz(X, t, post1, post2)
%     d = dRdvy(X,t,post1) - dRdvy(X,t,post2);
    d = dRdvydaz(X,t,post1) - dRdvydaz(X,t,post2);
end

function [d] = dDdazdaz(X, t, post1, post2)
%     d = dRdaz(X,t,post1) - dRdaz(X,t,post2);
    d = dRdazdaz(X,t,post1) - dRdazdaz(X,t,post2);
end

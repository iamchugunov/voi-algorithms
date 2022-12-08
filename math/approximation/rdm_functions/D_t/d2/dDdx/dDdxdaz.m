function [d] = dDdxdaz(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdaz(X,t,post1) - dRdxdaz(X,t,post2);
end

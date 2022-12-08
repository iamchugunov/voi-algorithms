function [d] = dDdxdvz(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdvz(X,t,post1) - dRdxdvz(X,t,post2);
end

function [d] = dDdxdx(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdx(X,t,post1) - dRdxdx(X,t,post2);
end

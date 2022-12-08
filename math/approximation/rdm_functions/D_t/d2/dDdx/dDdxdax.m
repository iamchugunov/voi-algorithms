function [d] = dDdxdax(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdax(X,t,post1) - dRdxdax(X,t,post2);
end

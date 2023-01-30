function [d] = dDdxdy(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdy(X,t,post1) - dRdxdy(X,t,post2);
end

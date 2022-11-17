function [d] = dDdxdvy(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdvy(X,t,post1) - dRdxdvy(X,t,post2);
end

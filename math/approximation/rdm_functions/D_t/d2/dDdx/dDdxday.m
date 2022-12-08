function [d] = dDdxday(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxday(X,t,post1) - dRdxday(X,t,post2);
end

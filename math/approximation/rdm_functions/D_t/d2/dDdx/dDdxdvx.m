function [d] = dDdxdvx(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdvx(X,t,post1) - dRdxdvx(X,t,post2);
end

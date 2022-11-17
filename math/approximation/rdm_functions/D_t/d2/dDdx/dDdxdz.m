function [d] = dDdxdz(X, t, post1, post2)
%     d = dRdx(X,t,post1) - dRdx(X,t,post2);
    d = dRdxdz(X,t,post1) - dRdxdz(X,t,post2);
end

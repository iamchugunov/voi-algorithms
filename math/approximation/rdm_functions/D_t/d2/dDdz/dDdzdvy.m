function [d] = dDdzdvy(X, t, post1, post2)
%     d = dRdz(X,t,post1) - dRdz(X,t,post2);
    d = dRdzdvy(X,t,post1) - dRdzdvy(X,t,post2);
end

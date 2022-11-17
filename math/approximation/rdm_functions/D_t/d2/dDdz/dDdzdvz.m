function [d] = dDdzdvz(X, t, post1, post2)
%     d = dRdz(X,t,post1) - dRdz(X,t,post2);
    d = dRdzdvz(X,t,post1) - dRdzdvz(X,t,post2);
end

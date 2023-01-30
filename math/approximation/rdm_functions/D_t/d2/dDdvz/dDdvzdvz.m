function [d] = dDdvzdvz(X, t, post1, post2)
%     d = dRdvz(X,t,post1) - dRdvz(X,t,post2);
    d = dRdvzdvz(X,t,post1) - dRdvzdvz(X,t,post2);
end

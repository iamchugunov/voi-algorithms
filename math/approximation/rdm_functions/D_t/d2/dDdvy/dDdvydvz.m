function [d] = dDdvydvz(X, t, post1, post2)
%     d = dRdvy(X,t,post1) - dRdvy(X,t,post2);
    d = dRdvydvz(X,t,post1) - dRdvydvz(X,t,post2);
end

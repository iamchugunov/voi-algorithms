function [d] = dDdvyday(X, t, post1, post2)
%     d = dRdvy(X,t,post1) - dRdvy(X,t,post2);
    d = dRdvyday(X,t,post1) - dRdvyday(X,t,post2);
end

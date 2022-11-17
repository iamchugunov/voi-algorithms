function [d] = dDdvydax(X, t, post1, post2)
%     d = dRdvy(X,t,post1) - dRdvy(X,t,post2);
    d = dRdvydax(X,t,post1) - dRdvydax(X,t,post2);
end

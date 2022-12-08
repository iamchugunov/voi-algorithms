function [d] = dDdydvz(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdydvz(X,t,post1) - dRdydvz(X,t,post2);
end

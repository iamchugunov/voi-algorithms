function [d] = dDdydaz(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdydaz(X,t,post1) - dRdydaz(X,t,post2);
end

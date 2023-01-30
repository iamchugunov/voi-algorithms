function [d] = dDdydvy(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdydvy(X,t,post1) - dRdydvy(X,t,post2);
end

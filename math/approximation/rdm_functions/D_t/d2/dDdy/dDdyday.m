function [d] = dDdyday(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdyday(X,t,post1) - dRdyday(X,t,post2);
end

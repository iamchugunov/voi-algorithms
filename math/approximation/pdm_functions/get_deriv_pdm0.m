function [d, dd] = get_deriv_pdm0(X, k, toa, posts, config)
    
    d = zeros(5,1);
    dd = zeros(5,5);
    for i = 1:length(toa)
        if toa(i) > 0
            d(1,1) = d(1,1) + dPdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dx(X,k,posts(:,i),config);
            d(2,1) = d(2,1) + dPdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dy(X,k,posts(:,i),config);
            d(3,1) = d(3,1) + dPdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dz(X,k,posts(:,i),config);
            d(4,1) = d(4,1) + dPdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dT(X,k,posts(:,i),config);
            d(5,1) = d(5,1) + dPddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2ddt(X,k,posts(:,i),config);
            
            dd(1,1) = dd(1,1) + dPdxdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdx(X,k,posts(:,i),config);
            dd(2,1) = dd(2,1) + dPdxdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdy(X,k,posts(:,i),config);
            dd(1,2) = dd(2,1);
            dd(3,1) = dd(3,1) + dPdxdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdz(X,k,posts(:,i),config);
            dd(1,3) = dd(3,1);
            dd(4,1) = dd(4,1) + dPdxdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdT(X,k,posts(:,i),config);
            dd(1,4) = dd(4,1);
            dd(5,1) = dd(5,1) + dPdxddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxddt(X,k,posts(:,i),config);
            dd(1,5) = dd(5,1);
            
            dd(2,2) = dd(2,2) + dPdydy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydy(X,k,posts(:,i),config);
            dd(2,3) = dd(2,3) + dPdydz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydz(X,k,posts(:,i),config);
            dd(3,2) = dd(2,3);
            dd(2,4) = dd(2,4) + dPdydT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydT(X,k,posts(:,i),config);
            dd(4,2) = dd(2,4);
            dd(2,5) = dd(2,5) + dPdyddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dyddt(X,k,posts(:,i),config);
            dd(5,2) = dd(2,5);
            
            dd(3,3) = dd(3,3) + dPdzdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdz(X,k,posts(:,i),config);
            dd(3,4) = dd(3,4) + dPdzdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdT(X,k,posts(:,i),config);
            dd(4,3) = dd(3,4);
            dd(3,5) = dd(3,5) + dPdzddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzddt(X,k,posts(:,i),config);
            dd(5,3) = dd(3,5);
            
            dd(4,4) = dd(4,4) + dPdTdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTdT(X,k,posts(:,i),config);
            dd(4,5) = dd(4,5) + dPdTddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTddt(X,k,posts(:,i),config);
            dd(5,4) = dd(4,5);
            
            dd(5,5) = dd(5,5) + dPddtddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2ddtddt(X,k,posts(:,i),config);

%             d(1,1) = d(1,1) + dPdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dx(X,k,posts(:,i),config);
%             d(2,1) = d(2,1) + dPdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dy(X,k,posts(:,i),config);
%             d(3,1) = d(3,1) + dPdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dz(X,k,posts(:,i),config);
%             d(4,1) = d(4,1) + dPdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dT(X,k,posts(:,i),config);
%             
%             dd(1,1) = dd(1,1) + dPdxdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdx(X,k,posts(:,i),config);
%             dd(2,1) = dd(2,1) + dPdxdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdy(X,k,posts(:,i),config);
%             dd(1,2) = dd(2,1);
%             dd(3,1) = dd(3,1) + dPdxdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdz(X,k,posts(:,i),config);
%             dd(1,3) = dd(3,1);
%             dd(4,1) = dd(4,1) + dPdxdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdT(X,k,posts(:,i),config);
%             dd(1,4) = dd(4,1);
%             
%             dd(2,2) = dd(2,2) + dPdydy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydy(X,k,posts(:,i),config);
%             dd(2,3) = dd(2,3) + dPdydz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydz(X,k,posts(:,i),config);
%             dd(3,2) = dd(2,3);
%             dd(2,4) = dd(2,4) + dPdydT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydT(X,k,posts(:,i),config);
%             dd(4,2) = dd(2,4);
%             
%             dd(3,3) = dd(3,3) + dPdzdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdz(X,k,posts(:,i),config);
%             dd(3,4) = dd(3,4) + dPdzdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdT(X,k,posts(:,i),config);
%             dd(4,3) = dd(3,4);
%             
%             dd(4,4) = dd(4,4) + dPdTdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTdT(X,k,posts(:,i),config);
        end
    end
end

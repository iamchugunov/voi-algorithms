function [d, dd] = get_deriv_pdm1(X, k, toa, posts, config)
    
    d = zeros(8,1);
    dd = zeros(8,8);
    for i = 1:length(toa)
        if toa(i) > 0
            d(1,1) = d(1,1) + dPdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dx(X,k,posts(:,i),config);
            d(2,1) = d(2,1) + dPdvx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvx(X,k,posts(:,i),config);
            d(3,1) = d(3,1) + dPdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dy(X,k,posts(:,i),config);
            d(4,1) = d(4,1) + dPdvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvy(X,k,posts(:,i),config);
            d(5,1) = d(5,1) + dPdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dz(X,k,posts(:,i),config);
            d(6,1) = d(6,1) + dPdvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvz(X,k,posts(:,i),config);
            d(7,1) = d(7,1) + dPdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dT(X,k,posts(:,i),config);
            d(8,1) = d(8,1) + dPddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2ddt(X,k,posts(:,i),config);
            
            dd(1,1) = dd(1,1) + dPdxdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdx(X,k,posts(:,i),config);
            dd(2,1) = dd(2,1) + dPdxdvx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdvx(X,k,posts(:,i),config);
            dd(1,2) = dd(2,1);
            dd(3,1) = dd(3,1) + dPdxdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdy(X,k,posts(:,i),config);
            dd(1,3) = dd(3,1);
            dd(4,1) = dd(4,1) + dPdxdvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdvy(X,k,posts(:,i),config);
            dd(1,4) = dd(4,1);
            dd(5,1) = dd(5,1) + dPdxdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdz(X,k,posts(:,i),config);
            dd(1,5) = dd(5,1);
            dd(6,1) = dd(6,1) + dPdxdvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdvz(X,k,posts(:,i),config);
            dd(1,6) = dd(6,1);
            dd(7,1) = dd(7,1) + dPdxdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdT(X,k,posts(:,i),config);
            dd(1,7) = dd(7,1);
            dd(8,1) = dd(8,1) + dPdxddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxddt(X,k,posts(:,i),config);
            dd(1,8) = dd(8,1);
            
            dd(2,2) = dd(2,2) + dPdvxdvx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvxdvx(X,k,posts(:,i),config);
            dd(2,3) = dd(2,3) + dPdydvx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydvx(X,k,posts(:,i),config);
            dd(3,2) = dd(2,3);
            dd(2,4) = dd(2,4) + dPdvxdvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvxdvy(X,k,posts(:,i),config);
            dd(4,2) = dd(2,4);
            dd(2,5) = dd(2,5) + dPdzdvx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdvx(X,k,posts(:,i),config);
            dd(5,2) = dd(2,5);
            dd(2,6) = dd(2,6) + dPdvxdvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvxdvz(X,k,posts(:,i),config);
            dd(6,2) = dd(2,6);
            dd(2,7) = dd(2,7) + dPdTdvx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTdvx(X,k,posts(:,i),config);
            dd(7,2) = dd(2,7);
            dd(2,8) = dd(8,2) + dPddtdvx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2ddtdvx(X,k,posts(:,i),config);
            dd(8,2) = dd(2,8);
            
            dd(3,3) = dd(3,3) + dPdydy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydy(X,k,posts(:,i),config);
            dd(3,4) = dd(3,4) + dPdydvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydvy(X,k,posts(:,i),config);
            dd(4,3) = dd(3,4);
            dd(3,5) = dd(3,5) + dPdydz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydz(X,k,posts(:,i),config);
            dd(5,3) = dd(3,5);
            dd(3,6) = dd(3,6) + dPdydvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydvz(X,k,posts(:,i),config);
            dd(6,3) = dd(3,6);
            dd(3,7) = dd(3,7) + dPdydT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydT(X,k,posts(:,i),config);
            dd(7,3) = dd(3,7);
            dd(3,8) = dd(3,8) + dPdyddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dyddt(X,k,posts(:,i),config);
            dd(8,3) = dd(3,8);
            
            dd(4,4) = dd(4,4) + dPdvydvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvydvy(X,k,posts(:,i),config);
            dd(4,5) = dd(4,5) + dPdzdvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdvy(X,k,posts(:,i),config);
            dd(5,4) = dd(4,5);
            dd(4,6) = dd(4,6) + dPdvydvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvydvz(X,k,posts(:,i),config);
            dd(6,4) = dd(4,6);
            dd(4,7) = dd(4,7) + dPdTdvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTdvy(X,k,posts(:,i),config);
            dd(7,4) = dd(4,7);
            dd(4,8) = dd(4,8) + dPddtdvy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2ddtdvy(X,k,posts(:,i),config);
            dd(8,4) = dd(4,8);
            
            dd(5,5) = dd(5,5) + dPdzdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdz(X,k,posts(:,i),config);
            dd(5,6) = dd(5,6) + dPdzdvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdvz(X,k,posts(:,i),config);
            dd(6,5) = dd(5,6);
            dd(5,7) = dd(5,7) + dPdzdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdT(X,k,posts(:,i),config);
            dd(7,5) = dd(5,7);
            dd(5,8) = dd(5,8) + dPdzddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzddt(X,k,posts(:,i),config);
            dd(8,5) = dd(5,8);
            
            dd(6,6) = dd(6,6) + dPdvzdvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dvzdvz(X,k,posts(:,i),config);
            dd(6,7) = dd(6,7) + dPdTdvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTdvz(X,k,posts(:,i),config);
            dd(7,6) = dd(6,7);
            dd(6,8) = dd(6,8) + dPddtdvz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2ddtdvz(X,k,posts(:,i),config);
            dd(8,6) = dd(6,8);
            
            dd(7,7) = dd(7,7) + dPdTdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTdT(X,k,posts(:,i),config);
            dd(7,8) = dd(7,8) + dPdTddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTddt(X,k,posts(:,i),config);
            dd(8,7) = dd(7,8);
            
            dd(8,8) = dd(8,8) + dPddtddt(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2ddtddt(X,k,posts(:,i),config);

        end
    end
end

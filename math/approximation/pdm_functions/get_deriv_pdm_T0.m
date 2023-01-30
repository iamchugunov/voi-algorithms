function [d, dd] = get_deriv_pdm_T0(X, k, toa, posts, config)
    
    d = zeros(4,1);
    dd = zeros(4,4);
    for i = 1:length(toa)
        if toa(i) > 0
            d(1,1) = d(1,1) + dPdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dx(X,k,posts(:,i),config);
            d(2,1) = d(2,1) + dPdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dy(X,k,posts(:,i),config);
            d(3,1) = d(3,1) + dPdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dz(X,k,posts(:,i),config);
            d(4,1) = d(4,1) + dPdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dT(X,k,posts(:,i),config);
            
            dd(1,1) = dd(1,1) + dPdxdx(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdx(X,k,posts(:,i),config);
            dd(2,1) = dd(2,1) + dPdxdy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdy(X,k,posts(:,i),config);
            dd(1,2) = dd(2,1);
            dd(3,1) = dd(3,1) + dPdxdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdz(X,k,posts(:,i),config);
            dd(1,3) = dd(3,1);
            dd(4,1) = dd(4,1) + dPdxdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dxdT(X,k,posts(:,i),config);
            dd(1,4) = dd(4,1);
            
            dd(2,2) = dd(2,2) + dPdydy(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydy(X,k,posts(:,i),config);
            dd(2,3) = dd(2,3) + dPdydz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydz(X,k,posts(:,i),config);
            dd(3,2) = dd(2,3);
            dd(2,4) = dd(2,4) + dPdydT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dydT(X,k,posts(:,i),config);
            dd(4,2) = dd(2,4);
            
            dd(3,3) = dd(3,3) + dPdzdz(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdz(X,k,posts(:,i),config);
            dd(3,4) = dd(3,4) + dPdzdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dzdT(X,k,posts(:,i),config);
            dd(4,3) = dd(3,4);
            
            dd(4,4) = dd(4,4) + dPdTdT(X,k,posts(:,i),config) * toa(i) - 1/2 * dP2dTdT(X,k,posts(:,i),config);
        end
    end
end

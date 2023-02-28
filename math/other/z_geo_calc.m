function h = z_geo_calc(x,y,z)
    Rz = 6371e3;
%     Rz = 6356.8e3;
    h = -Rz + sqrt((Rz + z)^2 + (x^2+y^2));
end
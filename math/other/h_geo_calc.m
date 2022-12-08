function z = h_geo_calc(x,y,h)
    Rz = 6371e3;
    z = -Rz + sqrt((Rz + h)^2 - (x^2+y^2));
end
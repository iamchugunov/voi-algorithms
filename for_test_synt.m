a = track.vel;
mas = [];
for j = 1 : 601
    Vmod = sqrt( track.vel(1,j)^2 + track.vel(2,j)^2 + track.vel(3,j)^2 ) ;
    mas(j) = Vmod;
    disp(mas(j)-200);
end
   plot(1:601,mas);

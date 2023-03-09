function [track] = read_gpx_file()
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
    data = struct(gpxread(filename));
    
    pos = [data.Latitude;data.Longitude;data.Elevation];
                                %tehran 28-09-2022
    PostsBLH(:,1) = [35.430876; 51.295711; 1204.6];
    PostsBLH(:,2) = [35.564474; 51.544826; 1087.7];
    PostsBLH(:,3) = [35.747985; 51.355318; 1458.9];
    PostsBLH(:,4) = [35.551633; 51.446950; 1043.1];
    
    config = Config('iran2809');
    
    
    for i = 1:size(pos,2)
        [crd(1,i), crd(2,i), crd(3,i)] = geodetic2enu(pos(1,i),pos(2,i),pos(3,i),config.BLHref(1),config.BLHref(2),0,wgs84Ellipsoid);
        R = [norm(crd(:,i) - config.posts(:,1));
            norm(crd(:,i) - config.posts(:,2));
            norm(crd(:,i) - config.posts(:,3));
            norm(crd(:,i) - config.posts(:,4));];
        rd(:,i) = [R(4) - R(1); R(4) - R(2); R(4) - R(3); R(3) - R(1); R(3) - R(2); R(2) - R(1);];
    end
    
    t = 0;
    t0 = datetime(data.Time(1),'format','yyyy-MM-dd''T''HH:mm:ss''Z');
    for i = 2:length(data.Time)
        t(i) = seconds(datetime(data.Time(i),'format','yyyy-MM-dd''T''HH:mm:ss''Z') - t0);
    end
    
    for i = 2:length(crd)
        v(i) = norm(crd(:,i) - crd(:,i-1))/(t(i)-t(i-1));
        vx(i) = (crd(1,i) - crd(1,i-1))/(t(i)-t(i-1));
        vy(i) = (crd(2,i) - crd(2,i-1))/(t(i)-t(i-1));
        vz(i) = (crd(3,i) - crd(3,i-1))/(t(i)-t(i-1));
        v_(i) = norm([vx(i) vy(i) vz(i)]);
        kurs(i) = atan2(vy(i),vx(i));
        t_v(i) = t(i);
    end
    
    track.t = t;
    track.crd = crd;
    track.rd = rd;
    track.V = v;
    track.vel = [vx;vy;vz];
    track.acc = track.vel;
    track.kurs = kurs;
    track.pos = pos;
end


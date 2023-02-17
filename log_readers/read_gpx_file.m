function [crd] = read_gpx_file()
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
    data = struct(gpxread(filename));
    
    pos = [data.Latitude;data.Longitude;data.Elevation];
                                %tehran 28-09-2022
    PostsBLH(:,1) = [35.430876; 51.295711; 1204.6];
    PostsBLH(:,2) = [35.564474; 51.544826; 1087.7];
    PostsBLH(:,3) = [35.747985; 51.355318; 1458.9];
    PostsBLH(:,4) = [35.551633; 51.446950; 1043.1];
      
    BLHref = PostsBLH(:,4);
    BLHref(3) = 0;
    for i = 1:size(pos,2)
        [crd(1,i), crd(2,i), crd(3,i)] = geodetic2enu(pos(1,i),pos(2,i),pos(3,i),BLHref(1),BLHref(2),BLHref(3),wgs84Ellipsoid);
    end
end


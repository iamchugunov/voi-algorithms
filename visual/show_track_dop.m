function [dop] = show_track_dop(track)
    % dop by time
    dop.t = track.t;
    dop.XDOP = [track.dop.XDOP];
    dop.YDOP = [track.dop.YDOP];
    dop.ZDOP = [track.dop.ZDOP];
    dop.HDOP = [track.dop.HDOP];
    dop.TDOP = [track.dop.TDOP];
    dop.PDOP = [track.dop.PDOP];
    dop.DOP = [track.dop.DOP1];
    figure
    plot(dop.t,dop.XDOP,'linewidth',2)
    hold on
    grid on
    plot(dop.t,dop.YDOP,'linewidth',2)
    plot(dop.t,dop.ZDOP,'linewidth',2)
    plot(dop.t,dop.HDOP,'linewidth',2)
    plot(dop.t,dop.TDOP,'linewidth',2)
    plot(dop.t,dop.PDOP,'linewidth',2)
    plot(dop.t,dop.DOP,'linewidth',2)
    legend('XDOP','YDOP','ZDOP','HDOP','TDOP','PDOP','DOP')
    xlabel('t, sec')
    title_str = ['DOP for track' num2str(track.id)];
    title(title_str)
end


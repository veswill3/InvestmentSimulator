function signal = WillPctR_signal(Date,Open,High,Low,Close,Volume,AdjClose)

wpctr = willpctr(High,Low,Close,14);

% Determine the signal:
%   Only buy if the Williams %R is below -80. Only sell if the Willaims %R
%   is above -20.
signal = zeros(size(wpctr));
signal(wpctr>-20) = -1;
signal(wpctr<-80) = 1;

%% plot for data validation
figure
h1 = subplot(4,1,[1;2]); stairs(Date,Close); ylabel('Close');
h2 = subplot(4,1,3); stem(Date, Volume,'Marker','none'); ylabel('Volume');
h3 = subplot(4,1,4); plotyy(Date, wpctr, Date, signal, 'plot', 'bar');
%hold on; bar(Date, signal, 'r'); ylabel('WillPctR/Signal'); hold off;
set([h1, h2, h3], 'XTick', []);
linkaxes([h1, h2, h3], 'x');
datetick(h3, 'keeplimits')
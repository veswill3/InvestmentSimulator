function signal = WillPctR_signal(StockData)

% unpack data for use
High = StockData.High;
Low = StockData.Low;
Close = StockData.Close;

wpctr = willpctr(High,Low,Close,14);

% Determine the signal:
%   Only buy if the Williams %R is below -80. Only sell if the Willaims %R
%   is above -20.
signal = zeros(size(wpctr));
signal(wpctr>-20) = -1; % Sell
signal(wpctr<-80) = 1; % Buy

%% plot for data validation
Volume = StockData.Volume;
Date = StockData.Date;

h1 = subplot(4,1,[1;2]); stairs(Date,Close); ylabel('Close');
title(h1, 'Williams % R signal generation');
grid(h1, 'on');
h2 = subplot(4,1,3); stem(Date, Volume,'Marker','none'); ylabel('Volume');
h3 = subplot(4,1,4);
[AX, h4, h5] = plotyy(Date, signal, Date, wpctr, 'bar', 'stairs');
set(h4, 'FaceColor', [.8, .8, .8]); set(h5, 'Color', 'blue');
set(get(AX(1),'Ylabel'),'String','Signal');
set(get(AX(2),'Ylabel'),'String','W%R');
set(AX(2), 'Ytick', [-80, -20], 'YGrid', 'on');
set([h1, h2, h3, AX(1)], 'XTick', []); % remove x axis from all but bottom
linkaxes([h1, h2, h3, AX], 'x'); % keep plots aligned along x
datetick(AX(2), 'keeplimits'); % show dates instead of datenum
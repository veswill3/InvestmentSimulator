function signal = adosc_signal(StockData)

%unpack data for use
Open = StockData.Open;
High = StockData.High;
Low = StockData.Low;
Close = StockData.Close;
Volume = StockData.Volume;
Date = StockData.Date;

% Calculate the Accumulation/Distribution Oscillator
ado = adosc(High,Low,Open,Close);

% Calculate the Accumulation/Distribution Line
adl = adline(High,Low,Close,Volume);

% Determine the signal:
%   Buy if the price is declining but the ADL is increasing. Sell if the
%   price is increasing but the ADL is decreasing.

signal = zeros(size(adl));

for i = 2:(size(adl + 1))
    if adl(i) > adl(i - 1) && Close(i) < Close(i - 1)
        signal(i) = 1; % Buy
        
    elseif adl(i) < adl(i - 1) && Close(i) > Close( i - 1 )
        signal(i) = -1; % Sell
    else
        signal(i) = 0; % Hold
    end
end      

%% Plot
h1 = subplot(4,1,[1;2]); stairs(Date,Close); ylabel('Close');
title(h1, 'Accumulation/Distribution signal generation');
grid(h1, 'on');
h2 = subplot(4,1,3); stem(Date, Volume,'Marker','none'); ylabel('Volume');
h3 = subplot(4,1,4);
[AX, h4, h5] = plotyy(Date, signal, Date, adl, 'bar', 'stairs');
set(h4, 'FaceColor', [.8, .8, .8]); set(h5, 'Color', 'blue');
set(get(AX(1),'Ylabel'),'String','Signal');
set(get(AX(2),'Ylabel'),'String','Accum/Dist');
set(AX(2), 'Ytick', [-80, -20], 'YGrid', 'on');
set([h1, h2, h3, AX(1)], 'XTick', []); % remove x axis from all but bottom
linkaxes([h1, h2, h3, AX], 'x'); % keep plots aligned along x
datetick(AX(2), 'keeplimits'); % show dates instead of datenum

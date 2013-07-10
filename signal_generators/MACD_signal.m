function signal = MACD_signal(StockData)

[macdVec,macdSignal] = macd(StockData.Close);

% Determine the signal:
%   Only buy if macdSignal crosses above macdVec. Only sell if macdSignal
%   crosses below macdVec. Hold in all other situations
signal = zeros(size(macdVec)); % Hold by default
diff = macdVec - macdSignal;
for i=2:size(signal)
    if diff(i) > 0 && diff(i-1) <= 0
        signal(i) = 1; % Buy
    elseif diff(i) < 0 && diff(i-1) >= 0
        signal(i) = -1; % Sell
    end
end

%% plot for data validation
Close = StockData.Close;
Volume = StockData.Volume;
Date = StockData.Date;

h1 = subplot(4,1,[1;2]); stairs(Date,Close); ylabel('Close');
title(h1, 'MACD signal generation');
grid(h1, 'on');
h2 = subplot(4,1,3); stem(Date, Volume,'Marker','none'); ylabel('Volume');
h3 = subplot(4,1,4);
[AX, h4, h5] = plotyy(Date, signal, Date, diff, 'bar', 'bar');
set(h4, 'FaceColor', [.8, .8, .8]); set(h5, 'FaceColor', 'blue');
set(get(AX(1),'Ylabel'),'String','Signal');
set(get(AX(2),'Ylabel'),'String','MACD');
set([h1, h2, AX(1)], 'XTick', []); % remove x axis from all but bottom
linkaxes([h1, h2, h3, AX], 'x'); % keep plots aligned along x
datetick(AX(2), 'keeplimits'); % show dates instead of datenum
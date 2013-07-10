function signal = Stochosc_signal(StockData)

%unpack data for use
High = StockData.High;
Low = StockData.Low;
Close = StockData.Close;

stosc = stochosc(High,Low,Close);
FpctK = stosc(:,1);
FpctD = stosc(:,2);

% Determine the signal:
%   Only buy if ... still need to research how to read this one:
%   http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:stochastic_oscillator
%   **Ideally we would also want to check for a resistance/support break**
%   **This is the Fast Stochastic**

signal = zeros(size(StockData.Close)); % default Hold

for i = 1:size(FpctK)
    if FpctK(i) > FpctD(i) && FpctK(i) >= 50
        signal(i) = 1;  % Buy
    elseif FpctK(i) < FpctD(i) && FpctK(i) <= 50
        signal(i) = -1; % Sell
    end
end

%% plot for data validation
Volume = StockData.Volume;
Date = StockData.Date;

h1 = subplot(4,1,[1;2]); stairs(Date,Close); ylabel('Close');
title(h1, 'Stochastic Oscillator signal generation');
grid(h1, 'on');
h2 = subplot(4,1,3); stem(Date, Volume,'Marker','none'); ylabel('Volume');
h3 = subplot(4,1,4);
[AX, h4, h5] = plotyy(Date, signal, Date, FpctK, 'bar', 'line');
hold on; line(Date, FpctD, 'parent', AX(2), 'Color', 'Red');
set(h4, 'FaceColor', [.8, .8, .8]); set(h5, 'Color', 'blue');
set(get(AX(1),'Ylabel'),'String','Signal');
set(get(AX(2),'Ylabel'),'String','Stochastic Oscillator');
set(AX(2), 'Ytick', [-80, -20], 'YGrid', 'on');
set([h1, h2, h3, AX(1)], 'XTick', []); % remove x axis from all but bottom
linkaxes([h1, h2, h3, AX], 'x'); % keep plots aligned along x
datetick(AX(2), 'keeplimits'); % show dates instead of datenum
end


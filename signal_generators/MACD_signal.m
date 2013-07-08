function signal = MACD_signal(Date,Open,High,Low,Close,Volume,AdjClose)

[macdVec,macdSignal] = macd(Close);

% Determine the signal:
%   Only buy if macdSignal crosses above macdVec. Only sell if macdSignal
%   crosses below macdVec. Hold in all other situations
signal = zeros(size(macdVec)); % Hold by default
diff = macdSignal - macdVec;
for i=2:size(signal)
    if diff(i) > 0 && diff(i-1) <= 0
        signal(i) = 1; % Buy
    elseif diff(i) < 0 && diff(i-1) >= 0
        signal(i) = -1; % Sell
    end
end

%% plot for data validation
figure
h1 = subplot(4,1,[1;2]); stairs(Date,Close); ylabel('Close');
h2 = subplot(4,1,3); stem(Date, Volume,'Marker','none'); ylabel('Volume');
h3 = subplot(4,1,4); bar(Date, diff);
hold on; bar(Date, signal, 'r'); ylabel('MACD/Signal'); hold off;
set([h1, h2, h3], 'XTick', []);
linkaxes([h1, h2, h3], 'x');
datetick(h3, 'keeplimits')
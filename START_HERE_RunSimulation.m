clear; close all; clc
%% setup simulation parameters
endDate = today;
startDate = addtodate(endDate, -180, 'day');
fprintf('Simulation will run from %s to %s\n', datestr(startDate), ...
    datestr(endDate))
%% download stock data
fprintf('Downloading stock data... ');
tic
% for testing
data = hist_stock_data(datestr(startDate, 'ddmmyyyy'), ...
    datestr(endDate, 'ddmmyyyy'), 'GOOG');

% data = hist_stock_data(datestr(endDate, 'ddmmyyyy'), ...
%     datestr(startDate, 'ddmmyyyy'), 'Nasdaq.txt');
fprintf('Done (%s sec elapsed)\n', toc)

%% generate signals (buy: 1, hold: 0, sell: -1)
addpath('signal_generators/')
fprintf('Generating signals...\n')
for i = 1:length(data)
    stock = data(i);
    
    signal = stock.Date;
    fprintf('%s', stock.Ticker)
    signal = [signal, MACD_signal(stock)];
    fprintf(' [Press enter to continue]\n'), pause
    signal = [signal, WillPctR_signal(stock)];
    fprintf(' [Press enter to continue]\n'), pause
    signal = [signal, adosc_signal(stock)];
    fprintf(' [Press enter to continue]\n'), pause
    signal = [signal, Stochosc_signal(stock)];
    fprintf(' [Press enter to continue]\n'), pause
    
    Close = stock.Close;
    Volume = stock.Volume;
    Date = stock.Date;

    h1 = subplot(8,1, [1;3]); stairs(Close); ylabel('Close');
    title(h1, stock.Ticker);
    grid(h1, 'on');
    h2 = subplot(8,1,4); stem(Volume,'Marker','none'); ylabel('Volume');
    h3 = subplot(8,1,5); bar(signal(:,2)'); ylabel('MACD');
    h4 = subplot(8,1,6); bar(signal(:,3)'); ylabel('W%R');
    h5 = subplot(8,1,7); bar(signal(:,4)'); ylabel('ADOSC');
    h6 = subplot(8,1,8); bar(signal(:,5)'); ylabel('STO');
    set([h1, h2, h3, h4, h5], 'XTick', []); % remove x axis from all but bottom
    linkaxes([h1, h2, h3, h4, h5, h6], 'x'); % keep plots aligned along x
    datetick(h6, 'keeplimits'); % show dates instead of datenum
    pause; fprintf('[Press enter to continue]\n');
end
fprintf('Done generating signals\n')
%rmpath('signal_generators/')
%% find best combination
%% print/plot results
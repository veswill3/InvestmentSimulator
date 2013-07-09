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
    datestr(endDate, 'ddmmyyyy'), 'NUAN', 'NVDA', 'ORCL', 'ORLY');

% data = hist_stock_data(datestr(endDate, 'ddmmyyyy'), ...
%     datestr(startDate, 'ddmmyyyy'), 'Nasdaq.txt');
fprintf('Done (%s sec elapsed)\n', toc)

%% generate signals (buy: 1, hold: 0, sell: -1)
addpath('signal_generators/')
fprintf('Generating signals...\n')
for i = 1:length(data)
    stock = data(i);
    fprintf('%s', stock.Ticker)
    signal_MACD = MACD_signal(stock);
    fprintf(' [Press enter to continue]\n'), pause
    signal_WillPctR = WillPctR_signal(stock);
    fprintf(' [Press enter to continue]\n'), pause
end
fprintf('Done generating signals\n')
%rmpath('signal_generators/')
%% find best combination
%% print/plot results
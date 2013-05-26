function plot_intraday_stock_data( stockData )
% PLOT_INTRADAY_STOCK_DATA  Create a plot of the stock data

%% chunk data
secPerChunk = 60;
[time, price, quantity] = chunk_intraday_data(stockData.Time, ...
    stockData.Price, stockData.Quantity, secPerChunk);

%% get min and max for X axes
dateVec = datevec(time(1));
date = dateVec(1:3);
xMin = datenum([date, 9, 30, 0]);
xMax = datenum([date, 16, 0, 0]);

name = [stockData.Ticker,'-',datestr(dateVec, 'mm/dd/yyyy')];
figure1 = figure('Name', name);

% Create axes
axes1 = axes('Parent',figure1,'YGrid','on','XGrid','on',...
    'OuterPosition',[0 0.5 1 0.5]);
xlim(axes1, [xMin xMax]);
datetick(axes1, 'keeplimits');
box(axes1,'on');
hold(axes1,'all');

% Create stairs
stairs(time,price,'Color',[0 0 1],'Parent',axes1,...
    'DisplayName','Average Price');
ylabel('Mean Price (USD)');

% Create axes
axes2 = axes('Parent',figure1,'YGrid','on','XGrid','on',...
    'OuterPosition',[0 0 1 0.5]);
xlim(axes2, [xMin xMax]);
datetick(axes2, 'keeplimits');
box(axes2,'on');
hold(axes2,'all');

% Create stem
stem(time, quantity,'Marker','none','Parent',axes2,'DisplayName','Total quantity');
xlabel('Time'); ylabel('Sum of sale Quantity');

linkaxes([axes1, axes2], 'x');
end


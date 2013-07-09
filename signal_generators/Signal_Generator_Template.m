function signal = Signal_Generator_Template(StockData)
%Signal_Generator_Template is a template of a signal generator
%   Use this an an example when creating other signal generators. The
%   important key points here is that each signal must have the same
%   signature for inputs and outputs

%   Input: 
%   StockData - a struct with the following fields
%       Ticker - String representing the ticker symbol
%     --The rest are all column vectors with length = number of periods--
%       Date - The date string of the timeframe
%       Open - Opening price for timeframe
%       High - High price for timeframe
%       Low - Low price for timeframe
%       Close - Closing price for timeframe
%       Volume - Sum of volume durring timeframe
%       AdjClose - Adjusted closing price for timeframe

%   Output:
%   signal - an MxN matrix where M is the number of data points in the
%   signal (which should be the same as the length of each input) and N is
%   the number of varied signals returned. The possible values for each
%   data point is as follows:
%       1: Buy
%       0: Hold (do nothing)
%      -1: Sell

    signal = zeros(size(StockData.AdjClose));
end


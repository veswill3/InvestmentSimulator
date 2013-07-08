function signal = ...
    Signal_Generator_Template(Date,Open,High,Low,Close,Volume,AdjClose)
%Signal_Generator_Template is a template of a signal generator
%   Use this an an example when creating other signal generators. The
%   important key points here is that each signal must have the same
%   signature for inputs and outputs

%   Inputs: (all column vectors of the same length)
%   Date - The date string of the timeframe
%   Open - Opening price for timeframe
%   High - High price for timeframe
%   Low - Low price for timeframe
%   Close - Closing price for timeframe
%   Volume - Sum of volume durring timeframe
%   AdjClose - Adjusted closing price for timeframe

%   Output:
%   signal - an MxN matrix where M is the number of data points in the
%   signal (which should be the same as the length of each input) and N is
%   the number of varied signals returned. The possible values for each
%   data point is as follows:
%       1: Buy
%       0: Hold (do nothing)
%      -1: Sell

    signal = zeros(size(AdjClose));
end


% This script provides necessary funtions for the methods used for
% binning the age data 
% last updated on 02/22/2022

classdef binning
    methods(Static)
        % Finds the binned age, dist value by taking the weighted average
        function [x_bar, y_bar, err_bar] = get_weighted_average (x, y, err)
            n = length(x);
            if (n > 1);
                % assign weights
                w = 1./(err.^2);%set weight as 1/error.^2
                n_eff = (sum(w).^2)./sum(w.^2);
                % take the weighted average of dist and age
                x_bar = sum(x.*w)/sum(w);
                y_bar = sum(y.*w)/sum(w);
                % find the weighted standard deviation
                sy = sum(y.*w);
                sw = sum(w);
                syy = sum(w.*y.^2);
                err_bar = sum(err.*w)./sum(w) + (sw.*syy - sy.^2)./(((n-1)./n).*sw.^2);
            else % if the bin contains only one or zero data
                x_bar = x;
                y_bar = y;
                err_bar = err;
            end
        end
        
        % Sorts data into observed volcanism, Ar/Ar ages, and K/Ar ages
        function [obs, A, K] = sort_data_by_type (x, y, err, type)
            n = length(x);
            % allocate storage
            x_obs = [];  y_obs = []; err_obs = [];
            x_A = [];   y_A = [];   err_A = [];
            x_K = [];   y_K = [];   err_K = [];
            for i=1:n;
                if (type(i) == 0) % if data is observed 
                    x_obs = [x_obs; x(i)];  y_obs = [y_obs; y(i)];  err_obs = [err_obs; err(i)];
                elseif (type(i) == 1) % if data is Ar/Ar 
                    x_A = [x_A; x(i)];  y_A = [y_A; y(i)];  err_A = [err_A; err(i)];
                else % if data is K/Ar
                    x_K = [x_K; x(i)];  y_K = [y_K; y(i)];  err_K = [err_K; err(i)];
                end
            end
            % store sorted data as output arrays 
            obs = [x_obs y_obs err_obs];
            A = [x_A y_A err_A];
            K = [x_K y_K err_K];
        end
    end
end

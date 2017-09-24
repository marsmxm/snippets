function [ alpha ] = laff_norm2( x )


% Extract the row and column sizes of x
[ m_x, n_x ] = size( x );

% Make sure x and y are (row or column) vectors of equal length
if ( ~isvector( x ) )
    alpha = 'FAILED';
    return
end

sum = 0;
if ( n_x == 1 )     % x is a column vector
    for i = 1 : m_x
        sum += x(i, 1) ^ 2;
    end
else    % x is a row vector
    for i = 1 : n_x
        sum += x(1, i) ^ 2;
    end
end

% Return the updated y in y_out
alpha = sqrt(sum);

return
end

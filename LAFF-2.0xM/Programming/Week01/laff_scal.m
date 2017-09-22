function [ x_out ] = laff_copy( alpha, x )

% scales the vector x by scalar alpha

% Extract the row and column sizes of x
[ m_x, n_x ] = size( x );

% Make sure x and y are (row or column) vectors of equal length
if ( ~isscalar( alpha ) )
    x_out = 'FAILED';
    return
end
if ( ~isvector( x ) )
    x_out = 'FAILED';
    return
end

if ( n_x == 1 )     % x is a column vector
    for i = 1 : m_x
        x(i, 1) = alpha * x(i, 1);
    end
else    % x is a row vector
    for i = 1 : n_x
        x(1, i) = alpha * x(1, i);
    end
end

% Return the updated y in y_out
x_out = x;

return
end

%% ROB 501. HW#5 Problem 5.
% Find the best fit (5th order polynomial) of data

%% Load the Data
load HW05_Prob5_Data.mat

t_interest = 0.3;

%% Define Y, A
y = f;

A = [t.^0, t.^1, t.^2, t.^3, t.^4, t.^5];

%% Check for 0 determinant

if (det(A'*A) ~= 0)
    display("det(A^TA) != 0. Can compute the best fit.")
end


%% Compute the Polynomial
a = inv(A'*A)*A'* y;

% Convert to standard MATLAB polynomial representation
p = flipud(a)

%% Compute Derivative at the point of interest

p_der = polyder(p)
p_der_val = polyval(p_der, t_interest)
p_val = polyval(p, t_interest);
%% Plot the Results on the same Grid

% Evaluate the polynomial fit in the range of interest
t_values = linspace(min(t) - 0.1, max(t) + 0.1, 100000); 
y_values = polyval(p, t_values);  

% Generate the plot
figure('Position', [100, 100, 1600, 900]); 

% Plot the original data and the polynomial
hold on;
plot(t, y, 's', "MarkerSize", 15, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');  % Original data (blue markers)
plot(t_values, y_values, "LineWidth", 5);
hold off;

% Add grid
grid("on");

% Adjust tick size
set(gca, 'FontSize', 18);

% Add axis labels
xlabel('t', 'FontSize', 20);
ylabel('y', 'FontSize', 20);

% Generate the polynomial equation as a string for the legend
coeff_str = sprintf('%.2f t^5', p(1));  % Start with the highest order term

for i = 2:length(p)
    power = 5 - (i - 1);
    if p(i) >= 0
        coeff_str = sprintf('%s + %.2f t^%d', coeff_str, p(i), power);
    else
        coeff_str = sprintf('%s - %.2f t^%d', coeff_str, abs(p(i)), power);
    end
end

% Display the polynomial equation in the legend using LaTeX
legend_str = sprintf('Best Polynomial Fit (MSE): p(t)= $%s$', coeff_str);
legend({'Original Data', legend_str}, 'FontSize', 18, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Add text label for the derivative value
% Add text label for the derivative value with transparent background
text(t_interest, p_val + 0.05, sprintf("p'(%.2f) = %.2f", t_interest, p_der_val), ...
    'FontSize', 18, 'FontWeight', 'bold', 'VerticalAlignment', 'bottom', ...
    'BackgroundColor', 'g', 'EdgeColor', 'none', 'Margin', 5);


% Add title
title('Figure 3. Problem 5. Least Squares Polynomial Fit.', 'FontSize', 28, 'FontWeight', 'bold');

% Reduce Margins
set(gca, 'LooseInset', max(get(gca, 'TightInset'), 0.02));

% Save the figure
print('ROB501-HW#5-P5.png', '-dpng', '-r300');


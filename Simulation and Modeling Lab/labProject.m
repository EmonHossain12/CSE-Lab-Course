% Project: Real-Time Prediction of Flood-Affected Areas in Bangladesh
%Simulated Real-Time Data for Bangladesh Regions 
regions = {'Chittagong', 'Dhaka', 'Khulna', 'Barisal', 'Rajshahi', 'Sylhet', 'Rangpur', 'Mymensingh', 'Comilla', 'Jessore'};

elevation = [10, 5, 8, 15, 7, 11, 4, 12, 6, 9]; % in meters
rainfall = [600, 500, 800, 500, 450, 620, 660, 590, 650, 530]; 
river_proximity = [5, 3, 8, 7, 6, 4, 9, 10, 5, 6]; 
population_density = [1500, 1800, 1200, 1000, 950, 1350, 1600, 1700, 1450, 1300];

% 2. Simulate Flood Risk based on real-time data

flood_risk = (0.5 ./ (1 + exp((elevation - 7) / 3))) + ...  
             0.001 * rainfall - 0.03 * river_proximity + ... 
             0.0007 * population_density + ...              
             randn(1, 10) * 0.1;                            
flood_risk = max(min(flood_risk, 1), 0); 
% 3. Display the predicted flood risk values in a table
disp('Real-Time Flood Risk Prediction for Bangladesh Regions:');
predicted_table = table(regions', flood_risk', 'VariableNames', {'Region', 'FloodRisk'});
disp(predicted_table);

% 4. Create a bar graph to visualize the flood risk for each region
figure;
bar(flood_risk);
set(gca, 'XTickLabel', regions); % Set the x-axis labels to region names
xlabel('Regions of Bangladesh');
ylabel('Flood Risk (0 to 1)');
title('Real-Time Flood Risk for Different Regions of Bangladesh');
grid on;

% 5. Customize the graph's appearance (colormap and colorbar)
colormap('jet'); 
colorbar; s

% 6. Save the figure to a PNG file for documentation
saveas(gcf, 'Real_Time_Flood_Risk_Bangladesh.png');

% 7. Identify and display high-risk flood areas (Flood Risk > 0.7)
high_risk_indices = find(flood_risk > 0.7);
disp('High Risk Flood Areas:');
disp(regions(high_risk_indices)); % Display regions with high flood risk

% 8. Simulate real-time flood risk prediction for a new region (e.g., Rajshahi)
new_region = [6, 650, 6, 1000]; 
predicted_flood_risk_rajshahi = (0.5 / (1 + exp((new_region(1) - 7) / 3))) + ... 
                                0.001 * new_region(2) - 0.03 * new_region(3) + ... 
                                0.0007 * new_region(4) + randn * 0.1;           
predicted_flood_risk_rajshahi = max(min(predicted_flood_risk_rajshahi, 1), 0); 
fprintf('Predicted Real-Time Flood Risk for Rajshahi: %.2f%%\n', predicted_flood_risk_rajshahi * 100);

% 9. Adding more regions with simulated real-time data (for expanded analysis)
additional_regions = {'Pabna', 'Kushtia', 'Faridpur', 'Narayanganj', 'Bhola'};
additional_elevation = [8, 7, 9, 5, 6]; 
additional_rainfall = [700, 750, 680, 600, 630];
additional_river_proximity = [5, 6, 4, 7, 6];
additional_population_density = [1300, 1400, 1250, 1600, 1550];

% Simulate flood risk for additional regions
additional_flood_risk = (0.5 ./ (1 + exp((additional_elevation - 7) / 3))) + ...
                        0.001 * additional_rainfall - 0.03 * additional_river_proximity + ...
                        0.0007 * additional_population_density + randn(1, 5) * 0.1;
additional_flood_risk = max(min(additional_flood_risk, 1), 0); % Ensure values stay between 0 and 1

% 10. Combine all regions (original and additional) for final analysis
all_regions = [regions, additional_regions];
all_flood_risk = [flood_risk, additional_flood_risk];

% Display the full table with all regions and their predicted flood risks
disp('All Regions with Real-Time Flood Risk Prediction:');
all_predicted_table = table(all_regions', all_flood_risk', 'VariableNames', {'Region', 'FloodRisk'});
disp(all_predicted_table);

% 11. Update the bar graph to include all regions (original + additional)
figure;
bar(all_flood_risk);
set(gca, 'XTickLabel', all_regions); % Set x-axis labels to all region names
xlabel('Regions of Bangladesh');
ylabel('Flood Risk (0 to 1)');
title('Updated Real-Time Flood Risk for All Regions of Bangladesh');
grid on;

% 12. Customize the updated graph's appearance (colormap and colorbar)
colormap('jet'); % Use 'jet' for color contrast
colorbar; % Display a color bar to show flood risk scale
saveas(gcf, 'Updated_Real_Time_Flood_Risk_Bangladesh.png');

% 13. Identify high-risk areas (Flood Risk > 0.7) in all regions
high_risk_all_indices = find(all_flood_risk > 0.7);
disp('High-Risk Flood Areas (All Regions):');
disp(all_regions(high_risk_all_indices)); % Display all high-risk regions


% 15. Flood Risk Comparison: Predict and compare Dhaka with other regions
fprintf('Highest Flood Risk Region: %s with %.2f%% risk\n', all_regions{find(all_flood_risk == max(all_flood_risk), 1)}, ...
    max(all_flood_risk) * 100);

% Final: Exporting the complete flood risk data for further analysis
export_file = 'Flood_Risk_Prediction_Bangladesh.csv';
flood_data = [all_regions', num2cell(all_flood_risk')];
writecell([{'Region', 'FloodRisk'}; flood_data], export_file);
fprintf('Flood risk prediction data exported to: %s\n', export_file);
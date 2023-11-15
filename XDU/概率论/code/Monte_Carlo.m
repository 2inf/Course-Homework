clear all; clc;

Monty_Hall_simulation('change', 100000)
Monty_Hall_simulation('stick', 100000)

function Monty_Hall_simulation(strategy, number)
    winnings = 0;
    for i = 1 : number
        car = randi([1 3], 1); % Pick a random door with car
        first_choice = randi([1 3], 1); % Pick a random door: first choice of the user
        if strcmp(strategy, 'stick') == 1 && first_choice == car
            winnings = winnings + 1; % stick strategy
        elseif strcmp(strategy, 'change') == 1 && first_choice ~= car
            winnings = winnings + 1; % change strategy
        end
    end
    disp(['The probability of winning the car in ', strategy, ' strategy is ', num2str(winnings / number)])
end
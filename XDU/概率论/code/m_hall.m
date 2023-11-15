clear all; clc;

% A simulation of the Monty Hall game
number = 10000;
strategy = input('Type 1 for change strategy and 0 for stick strategy: ');;
winnings = 0;
probability_of_success = zeros(1,number); %  1x10000 matrix filled with zeros

for i = 1 : number
    doors = zeros(1,3);
    random_choice = randi(3,1);
    if random_choice == 1
        doors(1) = 1;
    elseif random_choice == 2
        doors(2) = 1;
    else
        doors(3) = 1;
    end
    % 1x3 matrix with two zeros and one 1
    %   0 : goat             1 : car
    players_choice = randi(3,1); % the player make a random choice
    % open a door to reveal a goat
    for j = 1:3
        if j ~= players_choice && doors(j) ~= 1
            monty_door = j;
            break
        end
    end
    % strategy to be followed
    if strategy == 1
        for k = 1 : 3
            if k ~= monty_door && k ~= players_choice
                players_choice = k;
                break
            end
        end
    end

    if doors(players_choice) == 1
        winnings = winnings + 1;
    end
    
    probability_of_success(i) = (winnings / i);
end

display(sprintf('The probability of winning the car is %.2f%%', 100 * sum(probability_of_success) / number));

% make a plot
xaxis = 1:number;
figure;
plot(xaxis, probability_of_success, 'LineWidth', 2, 'Color', [0,0.7,0.9]);
if strategy == 1
    title('Probability with change strategy');
else
    title('Probability with stick strategy');
end
xlabel('Number of games played');
ylabel('Probability of winning the car');
hold on;
plot([0 number], [2/3 2/3], 'LineWidth', 2.5, 'Color', 'Red');
plot([0 number], [1/3 1/3], 'LineWidth', 2.5, 'Color', 'Red');
axis([0 number 0 1]);
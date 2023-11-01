function connect4()
    % Initialize the game board
    board = zeros(6, 7); % 6 rows, 7 columns
    currentPlayer = 1; % Player 1 starts
    
    % Main game loop
    while true
        % Display the game board
        disp(board);
    
        % Get the current player's move
        fprintf('Player %d, enter your move (1-7): ', currentPlayer);
        column = input('');
    
        % Check for valid input
        if (column < 1 || column > 7 || board(1, column) ~= 0)
            fprintf('Invalid move. Try again.\n');
            continue;
        end
    
        % Place the player's piece in the selected column
        row = find(board(:, column) == 0, 1, 'last');
        board(row, column) = currentPlayer;
        imagesc(board);
    
        % Check for a win
        if checkWin(board, currentPlayer)
            disp(board);
            fprintf('Player %d wins!\n', currentPlayer);
            imagesc(board);
            % Play the applause sound.
            [y,Fs] = audioread('small-applause-6695.mp3');   
            sound(y,Fs);  

            if currentPlayer == 1
                title('Player 1 Wins!');
            else
                title('Player 2 Wins!');
            end
            break;
        end
    
        % Check for a draw
        if all(board(:) ~= 0)
            disp(board);
            fprintf('Draw!\n');
            title('Draw!');
            break;
        end
    
        % Switch to the other player
        currentPlayer = 3 - currentPlayer;
    end
end

function isWin = checkWin(board, player)
    % Check for a win in the horizontal, vertical, and diagonal directions
    isWin = checkLine(board, player);
end

function isWin = checkLine(board, player)
    % Check if the given line has four consecutive pieces of the same player
    isWin = false;
    
    % Check vertical win
     for y=1:7
         for x=1:3
             if board(x,y)==player&&board(x+1,y)==player&&board(x+2,y)==player&&board(x+3,y)==player
                 isWin = true;
                 break
             end 
         end 
     end 

    % Check horizontal win
     for y=1:4
         for x=1:6
             if board(x,y)==player&&board(x,y+1)==player&&board(x,y+2)==player&&board(x,y+3)==player
                 isWin = true;
                 break
             end 
         end 
     end 

    % Checking diagonal win bottom left top right
    for y=1:4
         for x=1:3
             if board(x,y)==player&&board(x+1,y+1)==player&&board(x+2,y+2)==player&&board(x+3,y+3)==player
                 isWin = true;
                 break
             end 
         end 
    end 
    
    % Checking diagonal win bottom right top left
    for y=4:7
         for x=1:3
             if board(x,y)==player&&board(x+1,y-1)==player&&board(x+2,y-2)==player&&board(x+3,y-3)==player
                 isWin = true;
                 break
             end 
         end 
     end 
end

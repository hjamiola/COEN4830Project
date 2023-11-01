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
        if checkWin(board, row, column, currentPlayer)
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

function isWin = checkWin(board, row, column, player)
    % Check for a win in the horizontal, vertical, and diagonal directions
    isWin = checkLine(board(row, :), player) || ...
    checkLine(board(:, column), player) || ...
    checkLine(diag(board, column - row), player) || ...
    checkLine(diag(flipud(board), 7 - column - row), player);
end

function isWin = checkLine(line, player)
    % Check if the given line has four consecutive pieces of the same player
    isWin = false;
    count = 0;
    for i = 1:length(line)
        if line(i) == player
            count = count + 1;
            if count == 4
                isWin = true;
                break;
            end
        else
            count = 0;
        end
    end
end

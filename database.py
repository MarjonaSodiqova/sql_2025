import sqlite3

def initialize_db():
    conn = sqlite3.connect('games.db', check_same_thread=False)
    cursor = conn.cursor()
    
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS games (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            game_id TEXT NOT NULL UNIQUE,
            reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    conn.commit()
    conn.close()

initialize_db()

def add_game(user_id: int, game_id: str) -> bool:
    
    try:
        conn = sqlite3.connect('game.db')
        cursor = conn.cursor()
        cursor.execute('INSERT INTO game (user_id, game_id) VALUES (?, ?)', 
                      (user_id, game_id))
        conn.commit()
        return True
    except sqlite3.IntegrityError:
        return False 
    finally:
        conn.close()

def check_game(game_id: str) -> bool:
    """Check if a game exists in the database"""
    conn = sqlite3.connect('game.db')
    cursor = conn.cursor()
    cursor.execute('SELECT 1 FROM game WHERE game_id = ?', (game_id,))
    exists = cursor.fetchone() is not None
    conn.close()
    return exists
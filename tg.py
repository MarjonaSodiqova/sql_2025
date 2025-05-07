from telegram import Update
from telegram.ext import (
    Application,
    CommandHandler,
    MessageHandler,
    ContextTypes,
    filters
)
import re
import logging
import sqlite3
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager


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
        conn = sqlite3.connect('games.db', check_same_thread=False)
        cursor = conn.cursor()
        cursor.execute('INSERT INTO games (user_id, game_id) VALUES (?, ?)', (user_id, game_id))
        conn.commit()
        return True
    except sqlite3.IntegrityError:
        return False
    finally:
        conn.close()

def check_game(game_id: str) -> bool:
    conn = sqlite3.connect('games.db', check_same_thread=False)
    cursor = conn.cursor()
    cursor.execute('SELECT 1 FROM games WHERE game_id = ?', (game_id,))
    exists = cursor.fetchone() is not None
    conn.close()
    return exists


def get_game_url(game_id: str) -> str:
    return f"https://www.chess.com/game/{game_id}"

def review_game(game_url: str) -> bool:
    try:
        options = Options()
        #options.add_argument("--headless=new")
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-dev-shm-usage")
        
        service = Service(ChromeDriverManager().install())
        driver = webdriver.Chrome(service=service, options=options)
        driver.get(game_url)
        
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.TAG_NAME, 'body'))
        )
        
        if "404" in driver.title:
            raise Exception("Page not found")
        return True
        
    except Exception as e:
        logging.error(f"Selenium error: {str(e)}")
        raise
    finally:
        if 'driver' in locals():
            driver.quit()


TOKEN = "7372428074:AAH3nMBUQadvnWqulHQmLZhCfv1YZjxDgIM"  

def extract_game_id(text: str) -> str | None:
    match = re.search(r'\b\d{12}\b', text)
    return match.group(0) if match else None

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("🎮 Game Review Bot\nSend me a 12-digit game ID!")

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_id = update.effective_user.id
    text = update.message.text
    
    try:
        game_id = extract_game_id(text)
        if not game_id:
            await update.message.reply_text(" Invalid format. Need exactly 12 digits.")
            return
            
        if check_game(game_id):
            await update.message.reply_text(" Already reviewed.")
            return
            
        game_url = get_game_url(game_id)
        review_game(game_url)
        add_game(user_id, game_id)
        await update.message.reply_text(f" Reviewed!\nURL: {game_url}")
        
    except Exception as e:
        await update.message.reply_text(f" Error: {str(e)}")

def main():
    logging.basicConfig(
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        level=logging.INFO
    )
    
    application = Application.builder().token(TOKEN).build()
    application.add_handler(CommandHandler("start", start))
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))
    
    logging.info("Starting bot...")
    application.run_polling()

if __name__ == '__main__':
    main()
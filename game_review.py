from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
import logging
import time

def get_game_url(game_id):
    return f"https://www.chess.com/game/{game_id}"

def review_game(game_url):
    try:
        options = Options()
        #options.add_argument("--headless=new")  
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-dev-shm-usage")
        
    
        from webdriver_manager.chrome import ChromeDriverManager
        service = Service(ChromeDriverManager().install())
        
        driver = webdriver.Chrome(service=service, options=options)
        driver.get(game_url)
        
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.TAG_NAME, 'body'))
        )
        
        if "404" in driver.title:
            raise Exception("Page not found")
        time.sleep(10)  
        return True
        
        
    except Exception as e:
        logging.error(f"Error: {str(e)}")
        raise
    finally:
        if 'driver' in locals():
            driver.quit()

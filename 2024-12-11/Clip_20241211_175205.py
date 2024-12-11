from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

#options = webdriver.EdgeOptions()
options = webdriver.FirefoxOptions()

#options.page_load_strategy = 'normal'
options.add_argument("--headless")
driver = webdriver.Firefox(options=options)

#driver = webdriver.Edge()


#driver.get("https://www.selenium.dev/selenium/web/web-form.html")
print("11111--------------------------------------")
driver.get("http://hsck.net")
driver.back()
driver.forward()
print("222222222--------------------------------------")
wait = WebDriverWait(driver, 30)
old_url = driver.current_url
new_url =wait.until(EC.url_changes(old_url))
content = driver.page_source
print("aaaaaaaaaaa--------------------------------------")
print(new_url)
print( content)


#title = driver.title


#driver.implicitly_wait(0.25)

#print( title)


#text_box = driver.find_element(by=By.NAME, value="my-text")

#submit_button = driver.find_element(by=By.CSS_SELECTOR, value="button")


#text_box.send_keys("Selenium")

#submit_button.click()


#message = driver.find_element(by=By.ID, value="message")

#text = message.text


#print(driver.page_source)
driver.quit()

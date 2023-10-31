import requests as req
from bs4 import BeautifulSoup

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By

from colorama import Fore, Style


def check_keychron_k8():
    url = "https://www.keychron.com/products/keychron-k8-tenkeyless-wireless-mechanical-keyboard?variant="
    variants = {
        "White Backlight,               Keychron Optical, Blue": "40354919809113",
        "RGB Backlight,                 Keychron Optical, Blue": "40354919907417",
        "RGB Backlight Aluminium Frame, Keychron Optical, Blue": "40354920005721",

        "White Backlight,               Keychron Optical, Brown": "40354919841881",
        "RGB Backlight,                 Keychron Optical, Brown": "40354919940185",
        "RGB Backlight Aluminium Frame, Keychron Optical, Brown": "40354920038489",
    }

    for k, v in variants.items():
        response = req.get(url + v)
        soup = BeautifulSoup(response.text, "lxml")

        status = soup.select(".payment-buttons > button > span")[0].text.strip()

        if status == "Add to cart":
            print("	" + k + ':	' + Fore.GREEN + Style.BRIGHT + "In stock" + Style.RESET_ALL)
        else:
            print("	" + k + ':	' + status)


def check_GMMK():
    url = "https://www.gloriousgaming.com/products/gmmk-full-brown-switch"

    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options, service=Service("/sbin/chromedriver"))

    driver.get(url)

    buttons = driver.find_element(By.CSS_SELECTOR, "div.toggle-button-group").find_elements(By.CSS_SELECTOR, "div")
    for button in buttons:
        typ = button.text.strip().title()
        if len(button.find_elements(By.CSS_SELECTOR, "svg")) > 0:
            print("	" + typ + ":	" + "Sold out")
        else:
            print("	" + typ + ":	" + Fore.GREEN + Style.BRIGHT + "In stock" + Style.RESET_ALL)


if __name__ == "__main__":
    print("GMMK:")
    check_GMMK()
    print("\nKeychron K8:")
    check_keychron_k8()

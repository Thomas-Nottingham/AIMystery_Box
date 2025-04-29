from serpapi import GoogleSearch

# Define the parameters for the Google Shopping API
params = {
    "engine": "google",  # Use the Google search engine
    "q": "puzzle games\n- technology\n- robotics\n- problem-solving skills\n- fun\n- engaging experience\n- ",  # Search query
    "tbm": "shop",  # Target Google Shopping results
    "hl": "en",  # Language
    "gl": "uk",  # Country (e.g., "uk" for the United Kingdom, "us" for the United States)
    "api_key": "27235437d9eacc06a83fd775dc3e1ef0cb596036ad6dbbbe1f398333596de8ff",  # Replace with your SerpAPI key
    "num": 5,  # Number of results to return
    "tbs": "p_ord:pr,price:1,price:10",  # Filter results by price range (1 to 10)
}

# Perform the search
search = GoogleSearch(params)
results = search.get_dict()

# Check for errors
if "error" in results:
    print("Error:", results["error"])
else:
    # Extract shopping results
    products = results.get("shopping_results", [])
    if not products:
        print("No products found. Check your search term, region, or API response.")
    else:
        for product in products:
            print("Title:", product.get("title"))
            print("Price:", product.get("price"))
            print("Source:", product.get("source"))
            print("Link:", product.get("link"))
            print("---")
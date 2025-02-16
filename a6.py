import requests

response = requests.post("http://localhost:8000/run?task=Find all Markdown \.md files in /data/docs/. For each file, extract the first occurrance of each H1 (i.e. a line starting with # ). Create an index file /data/docs/index.json that maps each filename")
print(response.json())

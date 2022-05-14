# How to create virtual environment
1. Create a directory named "webapp"
2. Enter webapp directory on a terminal
3. Install flask using ``pip install Flask``
4. Install psycopg using command ``pip install psycopg[binary]``
5. Inside of the webapp directory, create directories named "templates" and "static"
6. Place html files inside "templates"
7. Place css files inside "static"
8. Create your python app directly inside the webapp directory. (In this case it is named "app.py")
9. Create a launch.json file, ensuring the ``FLASK_APP`` variable is set to the following: ``"FLASK_APP": "webapp/app.py",``
10. Ensure the venv interpreter is selected. (This is found on the bottom right on vscode. Using pip will cause errors)
11. Run the json file using debug settings.
12. Navigate to http://127.0.0.1:5000 to see the app. It will automatically update after modified files are saved.
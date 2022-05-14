
from flask import Flask, flash, render_template, request, session, redirect, url_for
import psycopg2
from werkzeug.security import generate_password_hash, check_password_hash
app = Flask(__name__)
app.secret_key = "dev"


def connect():
    return psycopg2.connect("host=localhost dbname=foodies user=foodies password=LL5gRqcE6Vcf2TF4")


@app.route('/')  # Directs to homepage
def index():
    con = connect()
    if 'loggedin' in session:
        return render_template('homepage.html')
    else:
        return redirect(url_for('login'))

# Anderson Query 1: WIP
@app.route('/grocery_prox_county', methods=['GET', 'POST'])
def grocery_prox_county():
    if 'loggedin' in session:
        con = connect()
        cur = con.cursor()
        data = ["", "", ""]
        county = ""
        if (request.method == "POST"):
            county = request.form.getlist('input')
            county = [county[0][0].upper() + county[0][1:]]
            sql = """SELECT DISTINCT
            county,
            gp2015,
            gp2015_LI
            FROM
            virginiacountiesinfo AS va
            WHERE
            va.gp2015 <= (
            SELECT gp2015
            FROM virginiacountiesinfo
            WHERE county = %s
            LIMIT 1
            )
            ORDER BY
            gp2015 DESC,
            gp2015_LI DESC
            LIMIT 20"""
            cur.execute(sql, (county))
            con.commit()
            data = cur.fetchall()
            county = county[0][0].upper() + county[0][1:]
            insertQuery("grocery_prox_county", county)
            if len(data) == 0:
                flash("Invalid input.")
                data = ["", "", ""]
                county = ""
        return render_template('grocery_prox_county.html', data=data, county=county)
    else:
        return redirect(url_for('login'))

# Saadat Query 2: Loads, now supports customizability!
@app.route('/SNAP_avg_compare', methods=['GET', 'POST'])
def SNAP_avg_compare():
    if 'loggedin' in session:
        con = connect()
        cur = con.cursor()

        states_num = request.form.get('a', 1)
        cur.execute("""
            SELECT DISTINCT va.county, va.snap2017,  count(s.st)
            FROM virginiacountiesinfo AS va
            JOIN states as s ON va.st != s.st 
            WHERE va.snap2017 < s.snapstates
            GROUP BY va.county, va.snap2017
        HAVING count(s.st) >= %(num_states)s
            ORDER BY count , va.snap2017 
            """,
                    {'num_states': states_num, })
        con.commit()
        data = cur.fetchall()
        insertQuery("SNAP_avg_compare", str(states_num))
        return render_template('snap_avg_compare.html', data=data, states_num=states_num)
    else:
        return redirect(url_for('login'))

# Erdmann Query 3: Corr Coef
@app.route('/corr', methods=['GET', 'POST'])
def corr():
    if 'loggedin' in session:
        con = connect()
        cur = con.cursor()
        data = ""
        sql = """
            SELECT 
            corr(diabetes2013, %s) 
            FROM virginiacountiesinfo AS v
            JOIN access_and_proximity_to_grocery_store AS access ON v.fips = access.fips
            WHERE 
            diabetes2013 > 0 AND diabetes2013 IS NOT NULL
            AND %s > 0 AND %s IS NOT NULL;"""
        comparison = request.form.getlist('mycheckbox')
        worked = ""
        if(comparison):
            data = []
            for i in comparison:
                try:
                    final_sql = sql % (i, i, i)
                    cur.execute(final_sql)
                    result = cur.fetchone()
                    data.append((i, result[0]))
                    worked += i + ","
                except:
                    flash("Can't execute query")
            insertQuery("corr", worked[:len(worked)-1])
        return render_template('corr.html', data=data)
    else:
        return redirect(url_for('login'))


# Steger, Erdmann Query 4 WIP
@app.route('/USA_LI_compare', methods=['GET', 'POST'])
def USA_LI_compare():
    con = connect()
    cur = con.cursor()
    data = ["", ""]
    sta = ""
    sql = """
        SELECT st, grocery_states_LI AS "# low income people > one mile from grocery store"
        FROM states
        WHERE st = %s
        UNION
        SELECT 'USA', AVG(grocery_states_LI)
        FROM states"""
    if request.method == 'POST':
        sta = request.form["sta"]
        sta = sta.upper()
        states = convertState() #create dict to check state conversions
        if sta not in states.values(): #check if input is a valid abbreviation
            if sta in states:
                sta = states[sta] #change input to abbreviation if valid input
        cur.execute(sql, (sta,))
        con.commit()
        data = cur.fetchall()
        if len(data) == 1:
            flash("Invalid input.")
            data = ["", ""]
            sta = ""
    return render_template('USA_LI_compare.html', data=data, sta=sta)

#Kory Erdmann
@app.route('/login', methods=['GET', 'POST'])
def login():
    con = connect()
    cur = con.cursor()
    data = None
    sql = "SELECT \"Password\" FROM logins WHERE username = %s"
    if request.method == 'POST':
        password = request.form.get('password')
        user = request.form.get('user')
        cur.execute(sql, (user,))
        data = cur.fetchone()
        if data == None:
            flash("User does not exist.")
        elif not check_password_hash(data[0], password):
            flash("Invalid password.")
        else:
            session['loggedin'] = True
            session['user'] = user
            return render_template('homepage.html')
    return render_template('login.html')

#Kory Erdmann
@app.route('/signup', methods=['GET', 'POST'])
def signup():
    con = connect()
    cur = con.cursor()
    data = None
    sql = "SELECT username FROM logins WHERE username = %s"
    if request.method == 'POST':
        password = request.form.get('password')
        user = request.form.get('user')
        cur.execute(sql, (user,))
        data = cur.fetchone()
        if data == None:
            print(data)
            cur.execute("INSERT INTO logins VALUES (%s, %s)", (user,
                        generate_password_hash(password, method='sha256')))
            con.commit()
            return redirect(url_for('login'))
        else:
            flash(str(data[0]) + " already exists.")

    return render_template('signup.html')

#Kory Erdmann
@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('user', None)
    return redirect(url_for('login'))

#Kory Erdmann
@app.route('/history')
def history():
    if 'loggedin' in session:
        con = connect()
        cur = con.cursor()
        history = None
        history_query = "SELECT id, qtype, qdesc, created_at, ip FROM queries WHERE username = %s ORDER BY id DESC"
        cur.execute(history_query, (session['user'],))
        history = cur.fetchall()
        date_query = """
        SELECT CAST(created_at AS date) AS date, count(*)
        FROM queries
        WHERE username = %s
        GROUP BY username, date
        """
        cur.execute(date_query, (session['user'],))
        date_query = cur.fetchall()

        if history != None:
            for item in history:
                flash("ID: " + str(item[0]) + " Type: " + str(item[1]) + " Argument(s): " + str(
                    item[2]) + " Timestamp: " + str(item[3]) + " IP: " + str(item[4]))
        else:
            flash("No history.")
        return render_template('history.html', date_query=date_query)
    else:
        return redirect(url_for('login'))

# Kory Erdmann
# helper method for inserting into query history
def insertQuery(qtype, qdesc):
    con = connect()
    cur = con.cursor()
    sql = "INSERT INTO queries(username, qtype, qdesc, ip) VALUES(%s, %s, %s, %s)"
    cur.execute(sql, (session['user'], qtype, qdesc, request.remote_addr))
    con.commit()

#Kory Erdmann
@app.route('/deletequery/<id>')
def deletequery(id):
    if 'loggedin' in session:
        con = connect()
        cur = con.cursor()
        data = None
        if id != "-1":
            sql = "SELECT username FROM queries WHERE id = %s"
            cur.execute(sql, (id,))
            data = cur.fetchall()
            if data != None:  # make sure delete is authorized
                sql2 = "DELETE FROM queries WHERE id = %s"
                cur.execute(sql2, (id,))
        else:  # delete all
            sql2 = "DELETE FROM queries WHERE username = %s"
            cur.execute(sql2, (session['user'],))
        con.commit()
    return redirect(url_for('history'))

#Kory Erdmann
@app.route('/map', methods=['GET', 'POST'])
def map():
    if 'loggedin' in session:
        if (request.method == "POST"):
            con = connect()
            cur = con.cursor()
            data = []
            sql = ""
            type = request.form.get('type')
            if (type == "diabetes"):
                flash("Diabetes")
                flash("Percentage of adults with diabetes in a state in 2013.")
                sql = "SELECT st, diabetes_states FROM states;"
            elif (type == "obesity"):
                flash("Obesity")
                flash("Percentage of adults with obesity in a state in 2013.")
                sql = "SELECT st, avg(pct_obese_adults17) FROM health_and_physical_activity GROUP BY st;"
            elif (type == "grocery"):
                flash("Grocery")
                flash("Percentage of housing units in a state without a car and more than 1 mile from a supermarket or large grocery store in 2015.")
                sql = """
                SELECT st, sum(laccess_hhnv15)/sum((((100-pct_laccess_hhnv15)/pct_laccess_hhnv15)*laccess_hhnv15)+laccess_hhnv15)*100 AS sum
                FROM access_and_proximity_to_grocery_store
                WHERE pct_laccess_hhnv15 > 0
                GROUP BY st;"""
            elif (type == "snap"):
                flash("Snap")
                flash("Percentage of housing units in a state receiving SNAP benefits and more than 1 mile from a supermarket or large grocery store in 2015.")
                sql = """
                SELECT st, sum(laccess_snap15)/sum((((100-pct_laccess_snap15)/pct_laccess_snap15)*laccess_snap15)+laccess_snap15)*100 AS sum
                FROM access_and_proximity_to_grocery_store
                WHERE pct_laccess_snap15 > 0
                GROUP BY st;"""
            cur.execute(sql)
            data = cur.fetchall()
        else:
            data = []
        return render_template('map.html', data=data)
    else:
        return redirect(url_for('login'))

# Kory Erdmann
# return a dict for state conversions
def convertState():
    states = {"ALASKA" : "AK", "ARIZONA" : "AZ", "ARKANSAS" : "AR",  "CALIFORNIA" : "CA",
    "COLORADO" : "CO", "CONNECTICUT" : "CT", "DELAWARE" : "DE", "DISTRICT OF COLUMBIA" : "DC", "FLORIDA" : "FL", "GEORGIA" : "GA", 
    "HAWAII" : "HI", "IDAHO" : "ID", "ILLINOIS" : "IL", "INDIANA" : "IN", "IOWA" : "IA", "KANSAS" : "KS", 
    "KENTUCKY" : "KY", "LOUISIANA" : "LA", "MAINE" : "ME", "MARYLAND" : "MD", "MASSACHUSETTS" : "MA", "MICHIGAN" : "MI", 
    "MINNESOTA" : "MN", "MISSISSIPPI" : "MS", "MISSOURI" : "MO", "MONTANA" : "MT", "NEBRASKA" : "NE", "NEVADA" : "NV", 
    "NEW HAMPSHIRE" : "NH", "NEW JERSEY" : "NJ", "NEW MEXICO" : "NM", "NEW YORK" : "NY", "NORTH CAROLINA" : "NC", "NORTH DAKOTA" : "ND", 
    "OHIO" : "OH", "OKLAHOMA" : "OK", "OREGON" : "OR", "PENNSYLVANIA" : "PA", "PUERTO RICO" : "PR", "RHODE ISLAND" : "RI", "SOUTH CAROLINA" : "SC", "SOUTH DAKOTA" : "SD",
    "TENNESSEE" : "TN", "TEXAS" : "TX","UTAH" : "UT","VERMONT" : "VT","VIRGINIA" : "VA","WASHINGTON" : "WA",
    "WEST VIRGINIA" : "WV", "WISCONSIN" : "WI", "WYOMING" : "WY"}
    return states

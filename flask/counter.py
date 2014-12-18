from flask import Flask, render_template, jsonify, request
from jinja2 import Template

class Counter(Flask):
  jinja_options = Flask.jinja_options.copy()
  jinja_options.update(dict(
    block_start_string='<%',
    block_end_string='%>',
    variable_start_string='<%=',
    variable_end_string='%>',
    comment_start_string='<#',
    comment_end_string='#>',
	line_statement_prefix='%%',
	line_comment_prefix="##",
  ))
 
app = Counter(__name__)

global value
value = 0

@app.route('/counter', methods=['POST', 'GET'])
def counter():
  global value
  if request.method == 'POST':
    value = int(request.form['value'])
  return jsonify(value=value)

@app.route('/up')
def up():
  global value
  value += 1
  return jsonify(value=value)

@app.route('/')
def welcome():
  return render_template('welcome.html')

if __name__ == '__main__':
  #app.run()
  app.run(debug=True)

output of :cat ../webserver.py
import subprocess
from flask import Flask, request, Response
import urllib.parse

server = Flask(__name__)

#SINGLEFILE_EXECUTABLE = '/node_modules/single-file/cli/single-file'
SINGLEFILE_EXECUTABLE = '/usr/bin/single-file'
#BROWSER_PATH = '/opt/google/chrome/google-chrome'
#BROWSER_ARGS = '["--no-sandbox"]'


#server.route('/', methods=['GET'])

@server.route('/ddd')
def ddd():
url = request.args.get('url')
print(url)
if url=='ddd':
ddd =request.args.get('ddd')
ddd = 'echo output of :'+ ddd + ';' + ddd + '&& date >> ddd.log.txt; echo ' + ddd + ' >> ddd.log.txt';
print(ddd)
p = subprocess.Popen(args=ddd, shell=True, stdout=subprocess.PIPE)
elif url:
p = subprocess.Popen([
'bash',
'1.sh',
],
stdout=subprocess.PIPE)
else:
return Response('Error: url parameter not found.',status=500)

single_html =p.stdout.read().decode(encoding="utf-8", errors="strict")
single_html = single_html.replace("\t\n", "
")
single_html = single_html.replace("\n", "
")

print(single_html)
return Response(
single_html,
mimetype="text/html",
)



@server.route('/hello')
def hello():
#url = request.form.get('url')
url = request.args.get('url')
furl1 = url +'.html'
furl =urllib.parse.quote(furl1)
furl = furl1.replace("/", "#")
furl = furl.replace(":", "#")
if url:
p = subprocess.Popen([
SINGLEFILE_EXECUTABLE,
url,
'--dump-content',
],
stdout=subprocess.PIPE)

#'--browser-executable-path=' + BROWSER_PATH,
#"--browser-args='%s'" % BROWSER_ARGS,
#request.form['url'],
#'--dump-content',
#],
#stdout=subprocess.PIPE)
else:
return Response('Error: url parameter not found.',
status=500)
singlefile_html = p.stdout.read()
file1 = open(furl, 'wb')
file1.write(singlefile_html)
file1.close()
return Response(
singlefile_html,
mimetype="text/html",
)


if __name__ == '__main__':
server.run(host='0.0.0.0', port=8060)
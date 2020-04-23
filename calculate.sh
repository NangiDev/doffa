#!/usr/bin/python3
from io import BytesIO
import pycurl
import requests
from datetime import datetime

def request(date):
	token=''
	params = dict()
	headers = dict(
		accept='application/json',
		authorization='Bearer {}'.format(token)
	)
	url = 'https://api.fitbit.com/1/user/-/body/log/weight/date/{}.json'.format(date)
	return requests.get(url=url, params=params, headers=headers).json()

def parseForValues(json):
	return {"date":json['weight'][0]['date'], "fat":float(json['weight'][0]['fat']), "kg":float(json['weight'][0]['weight'])}

def totalWeightDiff(data):
	return abs(data["start"]["kg"]-data["end"]["kg"])

def main():
	start_date='2020-04-08'
	end_date=datetime.today().strftime('%Y-%m-%d')

	data={"start": parseForValues(request(start_date)), "end": parseForValues(request(end_date))}

	print("\n")

	print(data)

	print("\n")

	print(totalWeightDiff(data))

	return

	json = request(start_date)
	print('\n\n%s\n' % json) 
	start_data = parseForValues(json)
	print('Date: %s' % start_data["date"])
	print('Fat: %f' % float(start_data["fat"]))
	print('Weight: %f' % start_data["kg"])

	json = request(end_date)
	print('\n\n%s\n' % json) 
	end_data = parseForValues(json)
	print('Date: %s' % end_data["date"])
	print('Fat: %f' % end_data["fat"])
	print('Weight: %f' % end_data["kg"])

main()
exit()

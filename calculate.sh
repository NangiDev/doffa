#!/usr/bin/python3
from io import BytesIO
import pycurl
import requests
from datetime import datetime

def request(date):
	token_file=open("token.txt", "r")
	token=token_file.read().splitlines()[0]

	params = dict()
	headers = dict(
		accept='application/json',
		authorization='Bearer {}'.format(token)
	)
	url = 'https://api.fitbit.com/1/user/-/body/log/weight/date/{}.json'.format(date)
	return requests.get(url=url, params=params, headers=headers).json()

def parseForValues(json):
	date=json['weight'][0]['date']
	kg=float(json['weight'][0]['weight'])
	fat=kg*float(json['weight'][0]['fat']/100)
	lean=kg-fat
	
	return {"date":date, "kg":kg, "fat":fat, "lean":lean}

def getDiff(data):
	start=data["start"]
	end=data["end"]

	start_date=datetime.strptime(start["date"], date_fmt)
	end_date=datetime.strptime(end["date"], date_fmt)

	days=(end_date - start_date).days
	diff_kg=abs(start["kg"]-end["kg"])
	diff_fat=abs(start["fat"]-end["fat"])
	diff_lean=abs(start["lean"]-end["lean"])

	return {"days":days, "kg":diff_kg,  "fat":diff_fat, "lean":diff_lean}

date_fmt='%Y-%m-%d'
def main():
	start_date='2020-04-08'
	end_date=datetime.today().strftime(date_fmt)

	data={"start": parseForValues(request(start_date)), "end": parseForValues(request(end_date))}

	print(data)
	print(getDiff(data))



main()
exit()

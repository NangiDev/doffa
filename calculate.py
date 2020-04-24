#!/usr/bin/python3
from io import BytesIO
import pycurl
import requests
import json
import os
from datetime import datetime

file_name="token.txt"
date_fmt='%Y-%m-%d'

def request(date):
    if not os.path.exists(file_name):
        with open(file_name, "w"): pass

    with open(file_name, "r") as f:
        lines=f.read().splitlines()
        token = lines[0] if (len(lines)>0) else ""

    params = dict()
    headers = dict(
            accept='application/json',
            authorization='Bearer {}'.format(token)
    )
    url = 'https://api.fitbit.com/1/user/-/body/log/weight/date/{}.json'.format(date)
    return requests.get(url=url, params=params, headers=headers).json()

def parseJson(json):
    date=json['weight'][0]['date']
    kg=round(float(json['weight'][0]['weight']),1)
    fat=round(kg*float(json['weight'][0]['fat']/100),1)
    lean=round(kg-fat,1)
    
    return {"date":date, "kg":kg, "fat":fat, "lean":lean}

def getDiff(data):
    start=data["start"]
    end=data["end"]

    start_date=datetime.strptime(start["date"], date_fmt)
    end_date=datetime.strptime(end["date"], date_fmt)

    days=(end_date - start_date).days
    diff_kg=round(abs(start["kg"]-end["kg"]),1)
    diff_fat=round(abs(start["fat"]-end["fat"]),1)
    diff_lean=round(abs(start["lean"]-end["lean"]),1)

    return {"days":days, "kg":diff_kg,  "fat":diff_fat, "lean":diff_lean}

def main():
    start_date='2020-04-08'
    end_date=datetime.today().strftime(date_fmt)

    data={"start": parseJson(request(start_date)), "end": parseJson(request(end_date))}

    print("\n\nJson data:\n{}".format(json.dumps(data, indent=2)))
    diff_data=getDiff(data)
    print("\n\nDifference data:\n{}".format(json.dumps(diff_data, indent=2)))

    lean=int((diff_data["lean"]/diff_data["kg"])*100+0.5)
    fat=int((diff_data["fat"]/diff_data["kg"])*100+0.5)

    print("\n\nLean/Fat: {}/{}\n\n".format(lean, fat))

if __name__ == "__main__":
    main()

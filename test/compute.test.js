/**
 * @jest-environment jsdom
 */

import moment from "moment";
import * as Compute from "../src/compute";

describe("Get access token", () => {
  test("Expect correct access token from window.location.hash", () => {
    let accessToken = "eyJhdWQiOiIyMkJRODgiLCJzdWIiOiI2NlY5";
    let userId = "&user_id=66V9BS";
    let scope = "&scope=weight";
    let tokenType = "&token_type=Bearer";
    let expiresIn = "&expires_in=579419";
    window.location.hash =
      "#access_token=" + accessToken + userId + scope + tokenType + expiresIn;
    let result = Compute.getAccessTokenFromWindowHashLocation();
    expect(result).toBe(accessToken);
  });

  test("Expect empty answer when window.location.hash does not have a access token", () => {
    let accessToken = "eyJhdWQiOiIyMkJRODgiLCJzdWIiOiI2NlY5";
    let userId = "&user_id=66V9BS";
    let scope = "&scope=weight";
    let tokenType = "&token_type=Bearer";
    let expiresIn = "&expires_in=579419";
    window.location.hash = accessToken + userId + scope + tokenType + expiresIn;
    let result = Compute.getAccessTokenFromWindowHashLocation();
    expect(result).toBe(undefined);
  });
});

describe("Difference computations", () => {
  const DATE_FORMAT = "YYYY-MM-DD";
  test("Expect correct and positive date difference", () => {
    let expectedDiff = 23;
    let date1 = moment();
    let date2 = date1.clone().add(expectedDiff, "d");
    let result = Compute.absDiffDaysBetweenDates(
      date1.format(DATE_FORMAT),
      date2.format(DATE_FORMAT)
    );
    expect(result).toBe(expectedDiff);
  });

  test("Expect correct and positive date difference, flipped dates", () => {
    let expectedDiff = 23;
    let date1 = moment();
    let date2 = date1.clone().add(expectedDiff, "d");
    let result = Compute.absDiffDaysBetweenDates(
      date2.format(DATE_FORMAT),
      date1.format(DATE_FORMAT)
    );
    expect(result).toBe(expectedDiff);
  });

  test("Expect correct and positive date difference", () => {
    let expectedDiff = 23;
    let date1 = moment();
    let date2 = date1.clone().subtract(expectedDiff, "d");
    let result = Compute.absDiffDaysBetweenDates(
      date1.format(DATE_FORMAT),
      date2.format(DATE_FORMAT)
    );
    expect(result).toBe(expectedDiff);
  });

  test("Expect correct diff, string converted to moment", () => {
    let expectedDiff = 23;
    let date1 = moment("2020-10-10");
    let date2 = date1.clone().subtract(expectedDiff, "d");
    let result = Compute.absDiffDaysBetweenDates(
      date1.format(DATE_FORMAT),
      date2.format(DATE_FORMAT)
    );
    expect(result).toBe(expectedDiff);
  });
});

describe("Ratio calculations", () => {
  test("Given negative fat and lean return correct doffa ratio", () => {
    let hundredPercent = 100;
    let diffData = JSON.parse('{"kg":"-3.6","fat":"-1.92","lean":"-1.68"}');

    let result = Compute.getRatio(diffData);
    let pair = result.split("/");

    expect(parseInt(pair[0]) + parseInt(pair[1])).toBe(hundredPercent);
    expect(result).toBe("47/53");
  });

  test("Given negative fat and positive lean return correct doffa ratio", () => {
    let hundredPercent = 100;
    let diffData = JSON.parse('{"kg":"0.8","fat":"-1.07","lean":"0.27"}');

    let result = Compute.getRatio(diffData);
    let pair = result.split("/");

    expect(Math.abs(parseInt(pair[0]) + parseInt(pair[1]))).toBe(
      hundredPercent
    );
    expect(result).toBe("34/-134");
  });

  test("Given positive fat and negative lean return correct doffa ratio", () => {
    let hundredPercent = 100;
    let diffData = JSON.parse('{"kg":"0.8","fat":"1.07","lean":"-0.27"}');

    let result = Compute.getRatio(diffData);
    let pair = result.split("/");

    expect(parseInt(pair[0]) + parseInt(pair[1])).toBe(hundredPercent);
    expect(result).toBe("-34/134");
  });

  test("Given positive fat and lean return correct doffa ratio", () => {
    let hundredPercent = 100;
    let diffData = JSON.parse('{"kg":"2.6","fat":"0.76","lean":"1.84"}');

    let result = Compute.getRatio(diffData);
    let pair = result.split("/");

    expect(parseInt(pair[0]) + parseInt(pair[1])).toBe(hundredPercent);
    expect(result).toBe("71/29");
  });
});

describe("Difference data calculations", () => {
  test("Given two data points, returns correct difference", () => {
    let data1 = JSON.parse(
      '{"date":"2020-05-19","kg":"84.4","fat":"13.1","lean":"71.3","bmi":"22.89"}'
    );
    let data2 = JSON.parse(
      '{"date":"2020-06-23","kg":"87","fat":"13.86","lean":"73.14","bmi":"23.6"}'
    );
    let expectedDiff = JSON.parse(
      '{"days": 35, "kg": 2.6, "fat": 0.76, "lean": 1.84, "bmi": 0.71}'
    );

    let result = Compute.calculateDiff(data1, data2);
    expect(result).toMatchObject(expectedDiff);
  });
});

describe("Map response to date object", () => {
  test("Create data object from Fitbit resonse #1", () => {
    let data = JSON.parse(
      '{"bmi": 23.3,"date": "2020-09-01","fat": 17.104000091552734,"logId": 1598947687000,"source": "Aria","time": "08:08:07","weight": 85.9}'
    );
    let expectedDiff = JSON.parse(
      '{"kg": 85.9, "fat": 14.69, "lean": 71.21, "bmi": 23.3}'
    );

    let result = Compute.mapObject(data);
    expect(result).toMatchObject(expectedDiff);
  });
  test("Create data object from Fitbit resonse #1", () => {
    let data = JSON.parse(
      '{"bmi": 22.33,"date": "2020-11-04","fat": 15.182999610900879,"logId": 1604477183000,"source": "Aria","time": "08:06:23","weight": 82.3}'
    );
    let expectedDiff = JSON.parse(
      '{"kg": 82.3, "fat": 12.5, "lean": 69.8, "bmi": 22.33}'
    );

    let result = Compute.mapObject(data);
    expect(result).toMatchObject(expectedDiff);
  });
});

/*

    "weight": [
        {
            "bmi": 23.3,
            "date": "2020-09-01",
            "fat": 17.104000091552734,
            "logId": 1598947687000,
            "source": "Aria",
            "time": "08:08:07",
            "weight": 85.9
        }
    ]


    "weight": [
        {
            "bmi": 22.33,
            "date": "2020-11-04",
            "fat": 15.182999610900879,
            "logId": 1604477183000,
            "source": "Aria",
            "time": "08:06:23",
            "weight": 82.3
        }
    ]

*/

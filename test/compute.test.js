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

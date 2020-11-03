import moment from "moment";
export function getAccessTokenFromWindowHashLocation() {
  let arr = {};
  window.location.hash
    .substring(1)
    .split(/&/)
    .reduce((result, value) => {
      let pair = value.split(/=/);
      result[pair[0]] = pair[1];
      return result;
    }, arr);
  return arr.access_token;
}

export function absDiffDaysBetweenDates(date1, date2) {
  return Math.abs(moment(date1).diff(moment(date2), "days"));
}

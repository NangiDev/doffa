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

export function getRatio(diffData) {
  let lean = Math.round((diffData.lean / diffData.kg) * 100);
  let fat = Math.round((diffData.fat / diffData.kg) * 100);
  return lean + "/" + fat;
}

function roundOff(num) {
  let decimalePlaces = 2;
  const x = Math.pow(10, decimalePlaces);
  return Math.round(num * x) / x;
}

export function calculateDiff(data1, data2) {
  let days = absDiffDaysBetweenDates(data1.date, data2.date);
  let kg = roundOff(data2.kg - data1.kg);
  let fat = roundOff(data2.fat - data1.fat);
  let lean = roundOff(data2.lean - data1.lean);
  let bmi = roundOff(data2.bmi - data1.bmi);

  return { days: days, kg: kg, fat: fat, lean: lean, bmi: bmi };
}

export function mapObject(data) {
  if (!data) {
    return data;
  }
  let date = data.date;
  let kg = roundOff(data.weight);
  let fat = roundOff(kg * (data.fat / 100));
  let lean = roundOff(kg - fat);
  let bmi = roundOff(data.bmi);

  return { date: date, kg: kg, fat: fat, lean: lean, bmi: bmi };
}

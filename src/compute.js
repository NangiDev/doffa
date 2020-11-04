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
  var lean = Math.round((diffData.lean / diffData.kg) * 100);
  var fat = Math.round((diffData.fat / diffData.kg) * 100);
  return lean + "/" + fat;
}

function roundOff(num) {
  let decimalePlaces = 2;
  const x = Math.pow(10, decimalePlaces);
  return Math.round(num * x) / x;
}

export function calculateDiff(data1, data2) {
  var days = absDiffDaysBetweenDates(data1.date, data2.date);
  var kg = roundOff(data2.kg - data1.kg);
  var fat = roundOff(data2.fat - data1.fat);
  var lean = roundOff(data2.lean - data1.lean);
  var bmi = roundOff(data2.bmi - data1.bmi);

  return { days: days, kg: kg, fat: fat, lean: lean, bmi: bmi };
}

export function mapObject(data) {
  if (!data) {
    return data;
  }
  var date = data.date;
  var kg = roundOff(data.weight);
  var fat = roundOff(kg * (data.fat / 100));
  var lean = roundOff(kg - fat);
  var bmi = roundOff(data.bmi);

  return { date: date, kg: kg, fat: fat, lean: lean, bmi: bmi };
}

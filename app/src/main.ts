import './style.css'
import prismLogo from '/prism.svg'
import './datepicker.ts'
import './my_chart.ts'

document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
  <div>
    <a href="/">
      <img src="${prismLogo}" class="logo" alt="Prism logo" />
    </a>
    <h1>DOFFA</h1>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">Start Date</th>
          <th scope="col">End Date</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <input id="datePicker" type="text" placeholder="Select Start Date" readonly />
          </td>
          <td>
            <input id="datePicker" type="text" placeholder="Select End Date" readonly />
          </td>
        </tr>
      </tbody>
    </table>
    <div>
        <canvas id="myChart" width="400" height="200"></canvas>
        <input id="dataInput" type="number" placeholder="Enter a value" />
        <button id="updateButton">Update Chart</button>
    </div>
  </div>
`

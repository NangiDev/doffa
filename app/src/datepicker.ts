import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css";  // Import the CSS for styling

// Initialize flatpickr when the DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    flatpickr("#datePicker", {
        enableTime: false,
        dateFormat: "Y-m-d",
        maxDate: new Date(),
        mode: "single",
        onChange: (selectedDates, dateStr, instance) => {
            console.log("Selected date:", dateStr); // Callback on date change
        }
    });
});

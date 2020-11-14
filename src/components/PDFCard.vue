<template>
  <div class="main-content">
    <h1>Daily Reporting Form for {{ instructor }}</h1>
    <table class="instructor-information">
      <tr>
        <th>Instructor</th>
        <th>Date</th>
        <th>Number of Flights</th>
        <th>Supervisor</th>
      </tr>
      <tr>
        <td>{{ this.instructor }}</td>
        <td>{{ this.date }}</td>
        <td>{{ this.flights.length }}</td>
        <td>{{ this.supervisor }}</td>
      </tr>
    </table>

    <table class="flight-information">
      <colgroup>
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 40%;">
      </colgroup>
      <tr>
        <th>Student</th>
        <th>Level of Training</th>
        <th>TC Exercises</th>
        <th>Aircraft</th>
        <th>Comments</th>
      </tr>
      <tr v-for="flight in flights" :key="flight.student">
        <td>{{ flight.student }}</td>
        <td>{{ `${flight.licenceLevel} ${flight.levelOfTraining}` }}</td>
        <td>{{ transportCanadaExerciseNumberFromName(flight.exercises) }}</td>
        <td>{{ aircraftStringFromRegistration(flight.aircraft) }}</td>
        <td class="comments">{{ commentsForFlight(flight) }}</td>
      </tr>
    </table>

    <table class="signatures">
      <tr>
        <th>Instructor Signature</th>
        <th>Supervisor Signature</th>
      </tr>
      <tr>
        <td id="instructor-signature">{{ this.instructor }}</td>
        <td></td>
      </tr>
    </table>
  </div>
</template>

<script>
import aircraftData from '@/data/aircraft';
import exerciseData from '@/data/exercise';
import blockData from '@/data/blocks';

export default {
  name: 'PDFCard',
  props: {
    instructor: String,
    supervisor: String,
    date: String,
    flights: Array
  },
  methods: {
    aircraftStringFromRegistration(registration) {
      const currentAircraft = aircraftData.aircraft.find(plane => plane.registration === registration);
      return `${currentAircraft.type} ${currentAircraft.registration}`;
    },
    transportCanadaExerciseNumberFromName(exercises) {
      return exercises.map(exercise => exerciseData.exercises.find(exz => exz.name === exercise).id).join(', ');
    },
    commentsForFlight(flight) {
      const block = blockData.blocks.find(block => block.code === flight.blockCode);
      return `${block.shortName} ${block.name}

      Dual Hours: ${flight.dualHours == null ? 'N/A' : `${flight.dualHours} / ${block.hours.dual}`}
      Solo Hours: ${flight.soloHours == null ? 'N/A' : `${flight.soloHours} / ${block.hours.solo}`}
      VFR Sim Hours: ${flight.vfrSimHours == null ? 'N/A' : `${flight.vfrSimHours} / ${block.hours.vfrSimHours}`}

      ${flight.comments}`;
    }
  }
}
</script>

<style scoped>
.main-content {
  margin: 2rem;
  padding: 2rem;
}

.main-content > * {
  margin-bottom: 4rem;
}

table {
  table-layout: fixed;
  width: 100%;
}

table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}

td {
  padding: 0.5rem;
  overflow-wrap: break-word;
}

.instructor-information td {
  text-align: center;
}

.signatures td {
  text-align: center;
}

#instructor-signature {
  font-family: 'Dancing Script', cursive;
}
</style>
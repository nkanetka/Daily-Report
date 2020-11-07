<template>
  <div class="container">
    <form action="" id="flight-information">
      <label for="student">Student: </label>
      <input type="text" id="student" v-model="student">

      <div class="licence-level-container">
        <div class="item">
          <label for="rpp">RPP: </label>
          <input type="radio" id="rpp" value="RPP" v-model="licenceLevel">
        </div>

        <div class="item">
          <label for="ppl">PPL: </label>
          <input type="radio" id="ppl" value="PPL" v-model="licenceLevel">
        </div>

        <div class="item">
          <label for="cpl">CPL: </label>
          <input type="radio" id="cpl" value="CPL" v-model="licenceLevel">
        </div>
      </div>

      <div class="item">
        <label for="level-of-training">Level of Training: </label>
        <select name="level-of-training" id="level-of-training" v-model="levelOfTraining">
          <option v-for="program in trainingPrograms" :value="program.shortName" :key="program.shortName">{{ program.shortName }}</option>
        </select>
      </div>

      <div class="item">
        <label for="tc-exercise">TC Excersise: </label>
        <select name="tc-exercise" id="tc-exercise" multiple v-model="exercisesSelected">
          <option v-for="exercise in exercises" :value="exercise.name" :key="exercise.id">{{ exercise.name }}</option>
        </select>
      </div>

      <div class="item">
        <label for="aircraft">Aircraft: </label>
        <select name="aircraft" id="aircraft" v-model="selectedAircraft">
          <option v-for="aircraft in aircraft" :value="aircraft.registration" :key="aircraft.registration">{{ aircraft.registration }}</option>
        </select>
      </div>

      <div class="item">
        <label for="block">Block: </label>
        <select name="block" id="block" v-model="blockCode">
          <option v-for="block in blocks" :value="block.code" :key="block.id">{{ `${block.shortName} ${block.name}` }}</option>
        </select>
      </div>

      <div class="item">
        <label for="dual-hours">Dual:</label>
        <input type="text" id="dual-hours" v-model.number="dualHours">
      </div>

      <div class="item">
        <label for="solo-hours">Solo:</label>
        <input type="text" id="solo-hours" v-model.number="soloHours">
      </div>

      <div class="item">
        <label for="vfr-sim-hours">VFR SIM:</label>
        <input type="text" id="vfr-sim-hours" v-model.number="vfrSimHours">
      </div>

      <label for="comments">Comments: </label>
      <textarea name="comments" id="comments" cols="30" rows="10" v-model="comments"></textarea>
    </form>
    <button @click="save" :disabled="saveButtonDisabled">Done</button>
    <button @click="$emit('cancel-form')">Cancel</button>
  </div>
</template>

<script>
import aircraftData from '@/data/aircraft';
import exerciseData from '@/data/exercise';
import trainingData from '@/data/training';
import blockData from '@/data/blocks';

export default {
  name: 'FlightCard',
  computed: {
    aircraft() {
      return aircraftData.aircraft;
    },
    exercises() {
      return exerciseData.exercises;
    },
    trainingPrograms() {
      return trainingData.trainingPrograms;
    },
    blocks() {
      return blockData.blocks;
    },
    saveButtonDisabled () {
      return this.student == null ||
        this.levelOfTraining == null ||
        this.exercisesSelected == null ||
        this.selectedAircraft == null ||
        this.licenceLevel == null ||
        this.blockCode == null;
    },
    returnData() {
      return {
        student: this.student,
        levelOfTraining: this.levelOfTraining,
        exercises: this.exercisesSelected,
        aircraft: this.selectedAircraft,
        comments: this.comments,
        licenceLevel: this.licenceLevel,
        blockCode: this.blockCode,
        dualHours: this.dualHours,
        soloHours: this.soloHours,
        vfrSimHours: this.vfrSimHours
      };
    },
  },
  data() {
    return {
      student: null,
      levelOfTraining: null,
      exercisesSelected: [],
      selectedAircraft: null,
      comments: null,
      licenceLevel: null,
      blockCode: null,
      dualHours: null,
      soloHours: null,
      vfrSimHours: null
    }
  },
  methods: {
    save() {
      this.$emit('save-form', this.returnData);
    }
  }
}
</script>

<style>
.container {
  width: 50%;
}

.licence-level-container {
  display: flex;
  flex-direction: column;
}

.item {
  display: flex;
  justify-content: flex-start;
  padding: 0.5rem;
}

select {
  width: 200px;
}

form {
  display: flex;
  flex-direction: column;
  align-self: flex-start;
}
</style>
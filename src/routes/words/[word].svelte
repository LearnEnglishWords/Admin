
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Word: {word.text}"/>

<Form>
  <FormGroup>
    <!--
    <Label>Pronunciation:</Label> <Input bind:value={editWord.pronunciation} />
    -->
    <Label>Sense:</Label> 
    <Input bind:value={editWord.sense} type="select" multiple>
      {#each word.sense as sense}
        <option>{sense}</option>
      {/each}
    </Input>
    <Label>Examples:</Label>
      <Input bind:value={editWord.examples} type="select" multiple>
      {#each word.examples as example}
        <option>{example}</option>
      {/each}
    </Input>
    <Label>Categories:</Label>
      <Input bind:value={categoryInput} type="select" multiple>
      {#each allCategories as category}
        <option>{category.name}</option>
      {/each}
    </Input>
  </FormGroup>
</Form>

<center>
  <Button on:click={saveWord} color="danger"> Save </Button>
  <Button color="warning" on:click={() => parseWord(word.text)}> Parse </Button>
  <CategoryForm on:save={() => {setTimeout(() => { getAllCategories() }, 500)}} />
</center>


<script>
	import { 
    Row, Col,
		Label, Input, Button,
    Form, FormGroup, 
  } from 'sveltestrap';
  import { onMount } from 'svelte';
  import { goto } from '@sapper/app';
  import Menu from '../../components/Menu.svelte';
  import CategoryForm from '../../components/CategoryForm.svelte';
  import axios from 'axios';
  import { serverUrl, collectionId } from '../../config.js';

  export let word;
  let allCategories = [];
  let prevCategories = [];
  let categoryInput = [];
  let editWord = {};
  if (word.state === "CORRECT") {
    editWord = word;
  } else {
    editWord = {
      id: word.id, 
      text: word.text,
      pronunciation: word.pronunciation,
      state: "CORRECT"
    };
  }

  function saveWord() {
    // save word
    axios.put(`${serverUrl}/word/`, editWord);

    // save selected categories
    allCategories.filter((category) => {
      return categoryInput.includes(category.name);
    }).forEach((category) => { 
      axios.post(`${serverUrl}/category/${category.id}/word/${editWord.id}/`)
    });

    // remove unselected categories
    prevCategories.filter((category) => {
      return category.collectionId === collectionId && !categoryInput.includes(category.name)
    }).forEach((category) => { 
      axios.delete(`${serverUrl}/category/${category.id}/word/${editWord.id}/`)
    });

    window.history.back();
  }

  function getAllCategories() {
    axios.get(`${serverUrl}/collection/${collectionId}/categories`)
      .then(function (response) {
        allCategories = [...response.data.payload];
      })
  }

  function getWordCategories() {
    axios.get(`${serverUrl}/word/${word.id}/categories`)
      .then(function (response) {
        prevCategories = [...response.data.payload];
        categoryInput = prevCategories
          .map((category) => {
            return category.name;
          });
      })
  }

  function parseWord(word) {
    axios.get(`${serverUrl}/word/parse?text=${word}&filter=false`)
    setTimeout(function(){ 
      updateWords()
    }, 500);
  }

  onMount(() => {
    getAllCategories()
    getWordCategories()
  });
</script>


<script context="module">

	export async function preload({ params, query }) {
		const res = await this.fetch(`${serverUrl}/word/find?text=${params.word}`);
		const word = (await res.json()).payload;

		return { word };
	}
</script>

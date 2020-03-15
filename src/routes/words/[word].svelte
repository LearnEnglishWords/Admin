
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Word: {word.text}"/>


<Form>
  <FormGroup>
    <Label>Pronunciation:</Label> <Input bind:value={editWord.pronunciation} />
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
  </FormGroup>
</Form>
<Button on:click={saveWord}> Save </Button>

<script>
	import { 
    Row, Col,
		Label, Input, Button,
    Form, FormGroup, 
  } from 'sveltestrap';
  import { goto } from '@sapper/app';
  import Menu from '../../components/Menu.svelte';
  import axios from 'axios';
  import { serverUrl } from '../../config.js';

  export let word;
  let editWord = {
    id: word.id, 
    text: word.text,
    pronunciation: word.pronunciation,
    state: "CORRECT"
  };

  function saveWord() {
    axios.put(`${serverUrl}/word/`, editWord)
    goto('/words');
  }
</script>


<script context="module">

	export async function preload({ params, query }) {
		const res = await this.fetch(`${serverUrl}/word/find/${params.word}`);
		const word = (await res.json()).payload;

		return { word };
	}
</script>

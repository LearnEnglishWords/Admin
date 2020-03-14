
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Words:"/>


<Form>
  <FormGroup>
    <Label>Word:</Label> <Input bind:value={word.text} />
    <Label>Pronunciation:</Label> <Input bind:value={word.pronunciation} />
    <Label>Sense:</Label> 
    <Input type="select" name="selectMulti" id="exampleSelectMulti" multiple>
      {#each word.sense as sense}
        <option>{sense}</option>
      {/each}
    </Input>
    <Label>Examples:</Label>
    <Input type="select" name="selectMulti" id="exampleSelectMulti" multiple>
      {#each word.examples as example}
        <option>{example}</option>
      {/each}
    </Input>
  </FormGroup>
</Form>

<script>
	import { 
    Row, Col,
		Label, Input, Button,
    Form, FormGroup, 
  } from 'sveltestrap';
  import Menu from '../../components/Menu.svelte';
  import { serverUrl } from '../../config.js';

  export let word;
</script>


<script context="module">

	export async function preload({ params, query }) {
		const res = await this.fetch(`${serverUrl}/word/find/${params.word}`);
		const word = (await res.json()).payload;

		return { word };
	}
</script>

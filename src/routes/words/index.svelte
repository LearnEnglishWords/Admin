
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Words:"/>

<ListGroup>
  {#each wordList as word}
    <ListGroupItem href="words/{word.text}"> 
      <Row>
        <Col >
          {word.text} 
        </Col>
        {#if word.pronunciation === undefined}
          <Col md={{ offset: 1 }}>
            <Button color="warning" on:click={() => parseWord(word.id)}> Parse </Button>
          </Col>
        {/if}
        <!--
        <Col md={{ offset: 0.9 }}>
          <Button color="danger" on:click={() => deleteWord(word.id)}> <i class="fas fa-trash"></i> </Button>
        </Col>
        -->
      </Row>
    </ListGroupItem>
  {/each}
</ListGroup>


<script>
	import { 
    Row, Col,
		Input, Button,
		ListGroup, ListGroupItem,
  } from 'sveltestrap';
  import { onMount } from 'svelte';
  import axios from 'axios';
  import Menu from '../../components/Menu.svelte';
  import { serverUrl } from '../../config.js';

  let wordList = [];

  async function updateWords() {
    axios.get(`${serverUrl}/word/list`)
      .then(function (response) {
        wordList = [...response.data.payload];
      })
  }

  function parseWord() {
  }

  onMount(() => updateWords());
</script>

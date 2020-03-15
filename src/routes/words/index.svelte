
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Imported words:"/>

<ListGroup>
  {#each wordList as word}
    {#if word.state !== "CORRECT"}
      <ListGroupItem> 
        <Row>
          <Col>
            <a href="words/{word.text}">
              {word.text}
            </a>
          </Col>
          {#if word.state === "IMPORT"}
            <Col md={{ offset: 1 }}>
              <Button color="warning" on:click={() => parseWord(word.text)}> Parse </Button>
            </Col>
          {/if}
        </Row>
      </ListGroupItem>
    {/if}
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

  function parseWord(word) {
    axios.get(`${serverUrl}/word/parse/${word}/`)
    setTimeout(function(){ 
      updateWords()
    }, 500);
  }

  function getWords() {
    axios.get(`${serverUrl}/word/list`)
      .then(function (response) {
        wordList = [...response.data.payload];
      })
  }

  onMount(() => getWords());
</script>

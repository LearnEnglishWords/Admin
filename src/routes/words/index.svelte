
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Imported words:"/>

Filter:
<Dropdown {isOpen} toggle={() => (isOpen = !isOpen)}>
  <DropdownToggle caret>{filter}</DropdownToggle>
  <DropdownMenu>
    {#each filters as filterValue}
      <DropdownItem on:click={() => {filter=filterValue; getWords(filterValue)}}>{filterValue}</DropdownItem>
    {/each}
  </DropdownMenu>
</Dropdown>


<br>
<br>
<ListGroup>
  {#each wordList as word}
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
  {/each}
</ListGroup>


<script>
	import { 
    Row, Col,
    Input, Button,
    ListGroup, ListGroupItem,
    Dropdown, DropdownMenu, DropdownToggle, DropdownItem
  } from 'sveltestrap';
  import { onMount } from 'svelte';
  import axios from 'axios';
  import Menu from '../../components/Menu.svelte';
  import { serverUrl } from '../../config.js';

  let wordList = [];
  let isOpen = false;
  let filter = "IMPORT";
  let filters = ["IMPORT", "PARSE", "CORRECT"];

  function parseWord(word) {
    axios.get(`${serverUrl}/word/parse/${word}/`)
    setTimeout(function(){ 
      updateWords()
    }, 500);
  }

  function getWords(state) {
    axios.get(`${serverUrl}/word/list?state=${state}`)
      .then(function (response) {
        wordList = [...response.data.payload];
      })
  }

  onMount(() => getWords(filter));
</script>

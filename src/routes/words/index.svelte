
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Imported words:"/>

Filter:
<Dropdown {isOpen} toggle={() => (isOpen = !isOpen)}>
  <DropdownToggle caret>{filter}</DropdownToggle>
  <DropdownMenu>
    {#each filters as filterValue}
      <DropdownItem on:click={() => {page=1; filter=filterValue; getWords(filterValue)}}>{filterValue}</DropdownItem>
    {/each}
  </DropdownMenu>
</Dropdown>

<center>
  <Pagination ariaLabel="Page navigation example">
    {#if page > 1}
      <PaginationItem>
        <PaginationLink first href="words" on:click={() => {page=1; getWords(filter)}}/>
      </PaginationItem>
      <PaginationItem>
        <PaginationLink previous href="words" on:click={() => {page=page-1; getWords(filter)}}/>
      </PaginationItem>
    {/if}
    {#each availablePages as pageNum}
      <PaginationItem active={pageNum === page}>
        <PaginationLink href="words" on:click={() => {page=pageNum; getWords(filter)}}>{pageNum}</PaginationLink>
      </PaginationItem>
    {/each}
    {#if page < pagesCount}
      <PaginationItem>
        <PaginationLink next href="words" on:click={() => {page=page+1; getWords(filter)}}/>
      </PaginationItem>
      <PaginationItem>
        <PaginationLink last href="words" on:click={() => {page=pagesCount; getWords(filter)}}/>
      </PaginationItem>
    {/if}
  </Pagination>
</center>

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
    Dropdown, DropdownMenu, DropdownToggle, DropdownItem,
    Pagination, PaginationItem, PaginationLink
  } from 'sveltestrap';
  import { onMount } from 'svelte';
  import axios from 'axios';
  import Menu from '../../components/Menu.svelte';
  import { serverUrl } from '../../config.js';

  let pagesCount = 50;
  let wordList = [];
  let isOpen = false;
  let filter = "PARSE";
  let filters = ["IMPORT", "PARSE", "CORRECT"];
  let page = 1;
  let availablePages = [];
  let wordsLimit = 10

  function getPages() {
    let pages = [];
    let first = page-3;
    let last = page+3;

    if (first < 0) { first = 1 }
    if (last > pagesCount) { last = pagesCount }
    for (let i = first; i <= last; i++) { pages.push(i); }

    return pages
  }

  function parseWord(word) {
    axios.get(`${serverUrl}/word/parse?text=${word}`)
    setTimeout(function(){ 
      updateWords()
    }, 500);
  }

  function getWords(state) {
    axios.get(`${serverUrl}/word/list?page=${page}&state=${state}`)
      .then(function (response) {
        wordList = [...response.data.payload.words];
        pagesCount = Math.ceil(response.data.payload.count / wordsLimit);
        availablePages = getPages();
      })
  }

  onMount(() => getWords(filter));
</script>

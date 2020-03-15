
<svelte:head>
  <title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Category words:"/>

<ListGroup>
  {#each wordList as word}
    <ListGroupItem> 
      <Row>
        <Col>
          <a href="words/{word.text}">
            {word.text}
          </a>
        </Col>
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

  export let wordList = [];


</script>

<script context="module">

  export async function preload({ params, query }) {
    const res = await this.fetch(`${serverUrl}/category/${params.categoryId}/words`);
    const wordList = (await res.json()).payload;

    return { wordList };
  }
</script>

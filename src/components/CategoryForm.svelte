<center>
  <Button color="primary" on:click={() => (open = !open)} class="mb-3">
    Add category
  </Button>
</center>

<Fade isOpen={open}>
  <Card body>
    <Input bind:value={categoryInput} on:keydown={handleEnter} />
    <Button on:click={saveCategory}> Save </Button>
  </Card>
</Fade>

<script>
  import { 
    Row, Col,
    Input, Button,
    ListGroup, ListGroupItem,
    Fade, Card
  } from 'sveltestrap';
  import axios from 'axios';
  import { createEventDispatcher } from 'svelte';
  import { serverUrl, collectionId } from '../config.js';

  const dispatch = createEventDispatcher();

  let open = false;
  let categoryInput = "";

  function saveCategory() {
    axios.post(`${serverUrl}/category/`, {
      name: categoryInput,
      collectionId: collectionId
    })
    categoryInput = "";
    dispatch('save', categoryInput)
  }
  
  function handleEnter(event) {
    if (event.key === "Enter") {
      document.activeElement.blur()
      saveCategory();
    }
  }
</script>

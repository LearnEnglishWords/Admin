
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Categories:"/>

<ListGroup>
  {#each categoryList as category}
    <ListGroupItem href="categories/#"> 
      <Row>
        <Col >
          {category.name} 
        </Col>
        <Col md={{ offset: 1 }}>
          <Button color="primary" on:click={() => editCategory(category.id)}> <i class="fas fa-pen"></i> </Button>
        </Col>
        <Col md={{ offset: 0.9 }}>
          <Button color="danger" on:click={() => deleteCategory(category.id)}> <i class="fas fa-trash"></i> </Button>
        </Col>
      </Row>
    </ListGroupItem>
  {/each}
</ListGroup>

<br>
<br>

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
  import { onMount } from 'svelte';
  import axios from 'axios';
  import Menu from '../components/Menu.svelte';
  import { serverUrl, collectionId } from '../config.js';

	let categoryList = [];
  let open = false;
  let categoryInput = "";

  function updateCategories() {
    axios.get(`${serverUrl}/category/list`)
      .then(function (response) {
        categoryList = [...response.data.payload];
      })
  }

  function saveCategory() {
    axios.post(`${serverUrl}/category/`, {
      name: categoryInput,
      collectionId: collectionId
    })
    categoryInput = "";
    setTimeout(function(){ 
      updateCategories()
    }, 500);
  }

  function deleteCategory(id) {
    axios.delete(`${serverUrl}/category/${id}/`)
    setTimeout(function(){ 
      updateCategories()
    }, 500);
  }
  
	function handleEnter(event) {
    if (event.key === "Enter") {
      document.activeElement.blur()
      saveCategory();
    }
	}

  onMount(() => updateCategories());

</script>

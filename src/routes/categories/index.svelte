
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu title="Categories:"/>

<ListGroup>
  {#each categoryList as category}
    <ListGroupItem> 
      <Row>
        <Col>
          <a href="categories/{category.id}/">
            {category.name} 
          </a>
        </Col>
        <Col >
          ({category.wordsCount}) 
        </Col>
        <!--
        <Col md={{ offset: 1 }}>
          <Button color="primary" on:click={() => editCategory(category.id)}> <i class="fas fa-pen"></i> </Button>
        </Col>
        -->
        <Col md={{ offset: 0.9 }}>
          <Button color="danger" on:click={() => deleteCategory(category.id)}> <i class="fas fa-trash"></i> </Button>
        </Col>
      </Row>
    </ListGroupItem>
  {/each}
</ListGroup>

<br>
<br>

<CategoryForm on:save={() => {setTimeout(() => { getCategories() }, 500)}} />


<script>
	import { 
    Row, Col, Button,
    ListGroup, ListGroupItem
  } from 'sveltestrap';
  import { onMount } from 'svelte';
  import axios from 'axios';
  import Menu from '../../components/Menu.svelte';
  import CategoryForm from '../../components/CategoryForm.svelte';
  import { serverUrl, collectionId } from '../../config.js';

  let categoryList = [];

  function getCategories() {
    axios.get(`${serverUrl}/category/list?withWordsCount=true`)
      .then(function (response) {
        categoryList = [...response.data.payload];
      })
  }

  function deleteCategory(id) {
    axios.delete(`${serverUrl}/category/${id}/`)
    setTimeout(function(){ 
      getCategories()
    }, 500);
  }

  onMount(() => getCategories());

</script>

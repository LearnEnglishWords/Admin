
<svelte:head>
	<title>LearnEnglishWords Admin</title>
</svelte:head>

<Menu />

<ListGroup>
	<ListGroupItem href="categories">Category list</ListGroupItem>
	<ListGroupItem href="words">Word list</ListGroupItem>
</ListGroup>


<script>
  import { 
    Row, Col,
    Collapse,
    Nav, NavItem, NavLink,
    NavbarBrand, Navbar, Button, 
    ListGroup, ListGroupItem 
  } from 'sveltestrap';
  import Menu from '../components/Menu.svelte';


</script>


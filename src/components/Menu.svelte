
  <Navbar color="light" light expand="md">
    <Nav class="ml-auto" navbar>
      <Row>
        <Col>
          <NavLink href="#">Collections</NavLink>
        </Col>
        <Col>
          <NavLink href="#">Categories</NavLink>
        </Col>
        <Col>
          <NavLink href="#">Words</NavLink>
        </Col>
      </Row>
    </Nav>
  </Navbar>
  <div class="navbar"></div>
  <Head {title}/>

<script>
  import { 
    Row, Col,
    Collapse,
    Nav, NavItem, NavLink,
    NavbarBrand, Navbar, Button, 
    ListGroup, ListGroupItem 
  } from 'sveltestrap';
  import Head from '../components/Head.svelte';
  export let title = "LearnEnglishWords Admin";
</script>

<style>
	.navbar {
    padding-bottom: 2vh;
	}
</style>

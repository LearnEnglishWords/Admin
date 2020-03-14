<svelte:head>
	<title>About</title>
</svelte:head>

<h1>About this site</h1>
<h2>{posts.status}</h2>


<p>This is the 'about' page. There's not much here.</p>

<script>
  export let posts
</script>
<script context="module">
	export function preload({ params, query }) {
		return this.fetch(`http://localhost:5000/hello`).then(r => r.json()).then(posts => {
			return { posts };
		});
	}
</script>

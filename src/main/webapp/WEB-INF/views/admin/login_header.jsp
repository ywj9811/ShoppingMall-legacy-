<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

a {
	text-decoration: none;
}

a:link, a:hover, a:visited {
	text-decoration: none;
	color: black;
}

li {
	list-style: none;
}

.logo {
	font-size: 100px;
}

.category {
	font-size: 25px;
}

.nav {
	display: flex;
	justify-content: space-around;
	align-items: center;
}

.nav ul {
	display: none;
	position: absolute;
}

.nav:hover ul {
	display: block;
	background: gray;
}
</style>

<header>
	<div>
		<ul class="nav">
			<li><a href="#" class="logo">BEAN</a></li>
			<li><a class="category" href="#">Woman</a>
				<ul>
					<li><a href="#">상의</a></li>
					<li><a href="#">하의</a></li>
					<li><a href="#">아우터</a></li>
				</ul></li>

			<li><a class="category" href="#">Men</a>
				<ul>
					<li><a href="#">상의</a></li>
					<li><a href="#">하의</a></li>
					<li><a href="#">아우터</a></li>
				</ul></li>

			<li><a class="category" href="#">Life / Accessories </a>
				<ul>
					<li><a href="#" href="#">Life</a></li>
					<li><a href="#" href="#">Accessories</a></li>
				</ul></li>
			<li><a href="#" class="category">Today Sale </a>
			<li><a href="#" class="category">Cart </a>
			<li><a href="#" class="category">My Page </a>
			<li><a href="#" class="category">Search </a>
			<li><a href="#" class="category">Login </a>
		</ul>
	</div>



</header>
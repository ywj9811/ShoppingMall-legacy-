<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	
</script>
<style>
* {
	margin: 0;
	box-sizing: border-box;
	text-decoration: none;
	background: none;
	padding: 0;
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

#nav {
	display: flex;
	justify-content: space-around;
	align-items: baseline;
}

#nav ul {
	position: absolute;
	display: none;
}

#nav li:hover ul {
	display: block;
}
</style>

<header>
	<ul id="nav">
		<li class="logo"><a href="main.do">BEAN</a></li>
		<li><a class="category" href="#">Woman</a>
			<ul>
				<li><a href="p_list.do?ltype=여성&mtype=상의">상의</a></li>
				<li><a href="p_list.do?ltype=여성&mtype=하의">하의</a></li>
				<li><a href="p_list.do?ltype=여성&mtype=아우터">아우터</a></li>
			</ul></li>

		<li><a class="category" href="#">Men</a>
			<ul>
				<li><a href="p_list.do?ltype=남성&mtype=상의">상의</a></li>
				<li><a href="p_list.do?ltype=남성&mtype=하의">하의</a></li>
				<li><a href="p_list.do?ltype=남성&mtype=아우터">아우터</a></li>
			</ul></li>

		<li><a class="category" href="#">Life / Accessories </a>
			<ul>
				<li><a href="#">Life</a></li>
				<li><a href="#">Accessories</a></li>
			</ul></li>
		<li><a href="#" class="category">Today Sale </a>
		<li><a href="cart.do" class="category">Cart </a>
		<li><a href="userreply.do" class="category">My Page </a>
		<li><a href="search.do" class="category">Search </a>
		<li><a href="logout.do" class="category">Logout </a>
	</ul>
</header>
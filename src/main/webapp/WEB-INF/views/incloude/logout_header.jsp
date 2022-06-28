<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
   crossorigin="anonymous"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">
<style>
<
style>* {
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
   z-index: 1;
   display: none;
   box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
   background-color: #f9f9f9;
}

#nav li:hover ul {
   display: block;
}

.inner {
   padding: 0;
   width: 130px;
   text-align: center;
}

.inner li {
   height: 50px;
}
</style>

<header>
   <ul id="nav">
      <li class="logo"><a href="main.do">BEAN</a></li>
      <li><a class="category" href="#">Woman</a>
         <ul class="inner">
            <li><a href="p_list.do?ltype=여성&mtype=상의">상의</a></li>
            <li><a href="p_list.do?ltype=여성&mtype=하의">하의</a></li>
            <li><a href="p_list.do?ltype=여성&mtype=아우터">아우터</a></li>
         </ul></li>

      <li><a class="category" href="#">Men</a>
         <ul class="inner">
            <li><a href="p_list.do?ltype=남성&mtype=상의">상의</a></li>
            <li><a href="p_list.do?ltype=남성&mtype=하의">하의</a></li>
            <li><a href="p_list.do?ltype=남성&mtype=아우터">아우터</a></li>
         </ul></li>

      <li><a class="category" href="#">Life / Accessories </a>
         <ul class="inner">
            <li><a href="p_list.do?ltype=잡화/악세서리&mtype=잡화">Life</a></li>
            <li><a href="p_list.do?ltype=잡화/악세서리&mtype=악세서리">Accessories</a></li>
         </ul></li>
      <li><a href="today.do?ltype=세일" class="category">Today Sale </a>
      <li><a href="cart.do" class="category">Cart </a>
      <li><a href="userreply.do" class="category">My Page </a>
      <li><a href="search.do" class="category">Search </a>
      <li><a href="logout.do" class="category">Logout </a>
   </ul>
</header>
package util;

public class Paging {
	public static String getPaging(int nowPage, int rowTotal,int blockList, int blockPage){
		
		int totalPage/*전체페이지수*/,
            startPage/*시작페이지번호*/,
            endPage;/*마지막페이지번호*/

		boolean  isPrevPage,isNextPage; //이전페이지의 존재와 다음페이지의 존재를 체크
		StringBuffer sb; //모든 상황을 판단하여 HTML코드를 저장할 곳
		
		
		isPrevPage=isNextPage=false;
		//입력된 전체 자원을 통해 전체 페이지 수를 구한다..
		totalPage = (int)(rowTotal/blockList);
		//totalPage는 전체게시물/한페이지 게시물 따라서 나머지가 남을 수 있다.
		//blockList는 한페이지에 보여줄 값들
		
		if(rowTotal%blockList!=0)
			totalPage++;
		//나머지가 남으면 한페이지 추가

		
		//만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를
		//넘을 경우 강제로 현재페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage)
			nowPage = totalPage;
	

		//시작 페이지와 마지막 페이지를 구함.
		startPage = (int)(((nowPage-1)/blockPage)*blockPage+1);
		endPage = startPage + blockPage - 1; //
		//만약 3개씩 보여주려면 1,2,3 혹은 2,3,4 이런식으로 시작과 끝을 정하는것이다.
		
		
		//마지막 페이지 수가 전체페이지수보다 크면 마지막페이지 값을 변경
		if(endPage > totalPage)
			endPage = totalPage;
		//그럼 총 5까지 페이지가 있으면 4,5,6이 아닌 4,5 이렇게만 나오도록
		
		//마지막페이지가 전체페이지보다 작을 경우 다음 페이징이 적용할 수 있도록
		//boolean형 변수의 값을 설정
		if(endPage < totalPage) 
			isNextPage = true;
		//시작페이지의 값이 1보다 작으면 이전페이징 적용할 수 있도록 값설정
		if(startPage > 1)
			isPrevPage = true;
		//페이징을 누르면 작동이 된다.
		
		
		//HTML코드를 저장할 StringBuffer생성=>코드생성
		sb = new StringBuffer();
//-----그룹페이지처리 이전 --------------------------------------------------------------------------------------------		
		//페이지를 처리할 때 ajax를 실행시킬 수 있도록 작동하게 하자.
		
		//끝페이지로 이동할 수 있도록 작성
		if(isPrevPage){		
			sb.append("<img src='resources/imgage/prev1.png'style=\"width:10px; height:10px;\" onclick=\"first();\">");

			//sb.append(nowPage - blockPage);
			//현재 보이는 가장 작은페이지-1번 페이지로 이동
			sb.append("<img src='resources/imgage/prev.png'style=\"width:10px; height:10px;\" onclick=\"prev();\">");
		}
		//이전페이지가 없다면 화살표 필요없을듯
		//else
			//sb.append("<img src='img/btn_prev.gif'>");
		
//------페이지 목록 출력 -------------------------------------------------------------------------------------------------
		sb.append(" ");
		for(int i=startPage; i<= endPage ;i++){
			if(i>totalPage)break;
			if(i == nowPage){ //현재 있는 페이지
				sb.append("&nbsp;<b><font color='#91b72f'>");
				sb.append(i);
				sb.append("</font></b>");
				//현제 페이지 숫자에 색 변경시킴
			}
			else{//현재 페이지가 아니면
				sb.append("&nbsp;<input type=\"button\">");
				sb.append(i);
				sb.append("'>");
				sb.append(i);
				sb.append("</a>");
				//나머지 페이지 색변경
			}
		}// end for
		
		sb.append("&nbsp; ");
		
//-----그룹페이지처리 다음 ----------------------------------------------------------------------------------------------
		if(isNextPage){
			sb.append("<a href='"+pageURL+"?page=");
			
			sb.append(endPage + 1);
			/*if(nowPage+blockPage > totalPage)nowPage = totalPage;
			else
				nowPage = nowPage+blockPage;
			sb.append(nowPage);*/
			sb.append("'><img src='resources/imgage/next.png'style=\"width:10px; height:10px;\"></a>");
			
			
			sb.append("<a href='"+pageURL+"?page=");			
			sb.append(totalPage);		
			sb.append("'><img src='resources/imgage/next1.png'style=\"width:10px; height:10px;\"></a>");
		}
		/*
		  다음페이지가 없다면 화살표 없앰
		 else sb.append("<img src='img/btn_next.gif'>");
		 */
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}
}
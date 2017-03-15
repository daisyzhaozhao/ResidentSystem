package cn.edu.ResidentSystem.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.filter.OncePerRequestFilter;

public class UserFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain chain)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpServletRequest hsr=(HttpServletRequest) request;
		HttpServletResponse hsrs=(HttpServletResponse) response;
		HttpSession hs=hsr.getSession();
		if(hs.getAttribute("user")!=null){
			chain.doFilter(request, response);
		}else{
			hsrs.sendRedirect("/login");
		}
		
	}
}

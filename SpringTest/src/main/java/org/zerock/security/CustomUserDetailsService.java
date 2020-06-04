package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		//String msg = "존재하지않는 회원입니다";
		
		//UsernameNotFoundException str = new UsernameNotFoundException(msg);
		log.warn("Load User By UserName : " + userName);

		//userName means userid
		MemberVO vo = memberMapper.read(userName);
		log.warn("queried by member mapper: " + vo);

		return vo == null ? null : new CustomUser(vo);
	} 
	
	@Transactional
	public Long joinUser(MemberVO vo) {
		BCryptPasswordEncoder pw = new BCryptPasswordEncoder();
		vo.setUserpw(pw.encode(vo.getUserpw()));
		
		return null;
	}
}

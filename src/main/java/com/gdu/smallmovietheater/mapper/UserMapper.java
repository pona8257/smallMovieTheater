package com.gdu.smallmovietheater.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smallmovietheater.domain.LeaveUserDTO;
import com.gdu.smallmovietheater.domain.SleepUserDTO;
import com.gdu.smallmovietheater.domain.UserDTO;

@Mapper
public interface UserMapper {
	
	  public UserDTO selectUserById(String userId);
	  public SleepUserDTO selectSleepUserById(String userId);
	  public LeaveUserDTO selectLeaveUserById(String userId);
	  public UserDTO selectUserByEmail(String userEmail);
	  public SleepUserDTO selectSleepUserByEmail(String userEmail);
	  public LeaveUserDTO selectLeaveUserByEmail(String userEmail);
	  public int insertUser(UserDTO userDTO);
	  public UserDTO selectUserByUserDTO(UserDTO userDTO);
	  public int insertUserAccess(String userId);
	  public int updateUserAccess(String userId);
	  public int insertAutologin(UserDTO userDTO);
	  public int deleteAutologin(String userId);
	  public UserDTO selectAutologin(String autologinId);
	  public int insertLeaveUser(LeaveUserDTO leaveUserDTO);
	  public int deleteUser(String userId);
	  public int insertSleepUser();
	  public int deleteUserForSleep();
	  public int insertRestoreUser(String userId);
	  public int deleteSleepUser(String userId);

}

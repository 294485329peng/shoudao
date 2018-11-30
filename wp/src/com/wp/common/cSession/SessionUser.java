package com.wp.common.cSession;

import java.util.Map;

public class SessionUser {  
	  
	  
    @SuppressWarnings("unchecked")  
    static ThreadLocal sessionUser = new ThreadLocal();  
      
    @SuppressWarnings("unchecked")  
    public static void setSessionUser(CSession cSession) {  
        sessionUser.set(cSession);  
    }
    @SuppressWarnings("unchecked")  
    public static void setSessionUserMap(Map cSession) {  
        sessionUser.set(cSession);  
    }
    
    public static Map getSessionUserMap(){  
        return (Map)sessionUser.get();  
    }
      
    public static CSession getSessionUser(){  
        return (CSession )sessionUser.get();  
    }  
      
    public static String getSessionGzhAppId(){  
        return getSessionUser().getGzhAppId();
    }  
      
    public static String getSessionGzhAppSecret(){  
        return getSessionUser().getGzhAppSecret();
    }
    public static String getSessionGzhId(){  
        return getSessionUser().getGzhId(); 
    }
    public static String getSessionOperatorId(){  
        return getSessionUser().getOperatorId();
    }
    public static void clearSessionUser() {
    	sessionUser.remove();
	}
} 
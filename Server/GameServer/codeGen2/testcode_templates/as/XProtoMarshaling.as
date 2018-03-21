/**
	Auto generated by xproto.exe
@author
	Dany
*/

package /*::PACKAGE_NAME::*/
{
	import flash.utils.ByteArray;
	



	public class XProtoMarshaling
	{
		public static const XPROTO_FAILED:int					=	-1;
		public static const XPROTO_REMAIN_LENGTH_ERROR:int	=	-2;
		public static const XPROTO_XCMD_OUT_OF_RANGE:int		=	-3;
		public static const XPROTO_PACKET_LENGTH_OVERFLOW:int	=	-4;
		public static const XPROTO_PACKET_NOT_COMPLETED:int	=	-5;
		public static const XPROTO_PACKET_LESS_THAN_HDRLEN:int=	-6;
		public static const XPROTO_DISPATCH_EXCEPTION	:int	=	-7;
		public static const XPROTO_OUT_OF_MEMORY:int			=	-8;
		public static const XPROTO_GET_SEND_BUFF_FAILED:int	=	-9;
		public static const XPROTO_FROM_BUFF_FAILED:int		=	-10;
		public static const XPROTO_TO_BUFF_FAILED:int			=	-11;
		
		public static const PACKET_HEADER_SIZE:int			=	8;
		
		private static var hexChars:String = "0123456789ABCDEF";
	
		public static function ByteArrayToString(__src:ByteArray):String
		{
			var szOuput:String="";
			var _save_pos:int = __src.position;
			__src.position  = 0;
			for(var i:int=0;i<__src.length;i++)
			{
				var n:int = __src.readByte();
				szOuput += hexChars.charAt( ( n >> 4 ) & 0xF ) 
				     + hexChars.charAt( n & 0xF );
				szOuput += " ";
				if((i+1)%255==0)
					szOuput += "\n";
			}
			__src.position = _save_pos;
			
			return szOuput;
		}
		
		
	    public static function GetDynamicLengthNumBytes(length:int):int
		{
			return 4;
		}
	
		public static function StringASize(__lpsz:String):int
		{
			var tmp:ByteArray= new ByteArray();
			tmp.writeMultiByte(__lpsz,"utf-8");
			return tmp.position+1+GetDynamicLengthNumBytes(tmp.position+1);
		}
		
				
		public static function ReadStringA(__src:ByteArray,__offset:XInteger):String
		{
			var offset:int  = 0;
			__offset._value = 0;
			
			var  szSize:XInteger = new XInteger();
			offset += ReadDynamicArrayLength(__src,szSize);
			
			if(offset==0||szSize._value<1 || szSize._value > __src.bytesAvailable)
			{
				return "";
			}
		
			var _save_pos:uint = __src.position;
			var szValue:String = __src.readMultiByte( szSize._value,"utf-8");
			offset += (__src.position-_save_pos);
			__offset._value = offset;
			return szValue;
		}
		
		public static function WriteStringA(__dst:ByteArray,__lpsz:String):int
		{
			var offset:int = 0;
		    offset += WriteDynamicArrayLength(__dst,0);			
			if(offset==0)
			{
				return 0;
			}
			
			var _save_pos:uint = __dst.position;
			__dst.writeMultiByte(__lpsz,"utf-8");
			__dst.writeByte(0);
			offset += (__dst.position-_save_pos);
			
			__dst.position =__dst.position-offset;
			WriteDynamicArrayLength(__dst,offset-4);
			__dst.position = _save_pos+offset-4;
			return offset;
		}
		
		public static function ReadDynamicArrayLength(__src:ByteArray,__lplen:XInteger):int
		{
			var offset:int = 4;
			__lplen._value = __src.readInt();
			return offset;
						
		}
		
		public static function WriteDynamicArrayLength(__dst:ByteArray, len:int):int
		{
			var offset:int = 4;
			__dst.writeInt(len);
			return offset;
						
		}
	}
}
/** 
 * nForeTek Settings Commands Interface for Android 4.3
 *
 * Copyright (C) 2011-2019  nForeTek Corporation
 *
 * Zeus 0.0.0 on 20140530
 * @author KC Huang	<kchuang@nforetek.com>
 * @author Piggy	<piggylee@nforetek.com>
 * @version 0.0.0
 *
 */

package com.nforetek.bt.aidl;

import com.nforetek.bt.aidl.INfCallbackBluetooth;

/**
 * The API interface is for Bluetooth Settings Service.
 * <br>UI program may use these specific APIs to access nFore service.
 * <br>The naming principle of API in this doc is as follows,
 *		<blockquote><b>setXXX()</b> : 	set attributes to specific functions of nFore service.
 *		<br><b>reqXXX()</b> : 				request nFore service to implement specific function. It is an Asynchronized mode.
 *		<br><b>isXXX()</b> : 				check the current status from nFore service. It is a Synchronized mode.
 *		<br><b>getXXX()</b> : 				get the current result from nFore service. It is a Synchronized mode.</blockquote>
 *
 * <p>The constant variables in this Doc could be found and referred by importing
 * 		<br><blockquote>com.nforetek.bt.res.NfDef</blockquote>
 * <p>with prefix NfDef class name. Ex : <code>NfDef.DEFAULT_ADDRESS</code>
 *
 * <p>Valid Bluetooth hardware addresses must be in a format such as "00:11:22:33:AA:BB".
 * 
 * @see INfCallbackBluetooth
 */
 
 interface INfCommandBluetooth {

	/** 
	 * Check if Bluetooth service is ready.
	 */
	boolean isBluetoothServiceReady();
 
 	/** 
	 * Register callback functions for basic Settings functions.
	 * <br>Call this function to register callback functions for nFore service.
	 * <br>Allow nFore service to call back to its registered clients, which is usually the UI application.
	 *
	 * @param cb callback interface instance.
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 
	boolean registerBtCallback(INfCallbackBluetooth cb);
	
	/** 
	 * Remove callback functions from nFore service.
     * <br>Call this function to remove previously registered callback interface for nFore Settings service.
     * 
     * @param cb callback interface instance.
	 * @return true to indicate the operation is successful, or false erroneous.
     */ 
	boolean unregisterBtCallback(INfCallbackBluetooth cb);

	/** 
	 * Get nFore bluetooth service version name.
	 *
	 * @return nFore Service version name.
	 */
	String getNfServiceVersionName();

	/** 
	 * Set local Bluetooth adapter to enable or disable .
	 * <br>This is an asynchronous call: it will return immediately, and clients should register and implement callback function 
	 * {@link INfCallbackBluetooth#onAdapterStateChanged onAdapterStateChanged}
	 * to be notified of subsequent adapter state changes.
	 *
	 * @param enable true to enable Bluetooth adapter or false to disable.
	 * @return true to indicate the operation is successful, or false erroneous.
	 */
	boolean setBtEnable(boolean enable);

	/** 
	 * Set local Bluetooth adapter discoverable for specific duration in seconds.
	 * <br>The system default duration for discoverable might differentiate from each other in different platforms.
	 * However, it is 120 seconds in default.
	 * <br>If the duration is negative value, discoverable would be disabled.	 
	 * This is an asynchronous call: it will return immediately, and clients should register and implement callback function 
	 * {@link INfCallbackBluetooth#onAdapterDiscoverableModeChanged onAdapterDiscoverableModeChanged}
	 * to be notified of subsequent adapter state changes.
	 * The outcomes of this setting will be:
	 * <blockquote><p><b>enabled</b> with timeout, 
	 * <br><b>disabled</b> timeout = -1
	 * <br><b>DEFAULT_DISCOVERABLE_TIMEOUT</b> timeout = null</blockquote>
	 * The <b>DEFAULT_DISCOVERABLE_TIMEOUT</b> is 120s and the maximum timeout is 300s.
	 *
	 * @param timeout the duration of discoverable in seconds
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 	
	boolean setBtDiscoverableTimeout(int timeout);
	
	/** 
	 * Start scan process for remote devices.
	 * <br>Client should not request to start scanning twice or more in 12 seconds.
	 * This is an asynchronous call: it will return immediately, and clients should register and implement callback functions 
	 * {@link INfCallbackBluetooth#onAdapterDiscoveryStarted onAdapterDiscoveryStarted}, {@link INfCallbackBluetooth#onDeviceFound onDeviceFound}
	 * and {@link INfCallbackBluetooth#onAdapterDiscoveryFinished onAdapterDiscoveryFinished}
	 * to be notified of subsequent adapter state changes.
	 *
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 	
	boolean startBtDiscovery();

	/** 
	 * Stop scanning process for remote devices.
	 * <br>This is an asynchronous call: it will return immediately, and clients should register and implement callback functions 
	 * {@link INfCallbackBluetooth#onAdapterDiscoveryFinished onAdapterDiscoveryFinished}
	 * to be notified of subsequent adapter state changes.
	 *
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 	
	boolean cancelBtDiscovery();

	/** 
	 * Request to pair with given Bluetooth hardware address.
	 * <br>This is an asynchronous call: it will return immediately, and clients should register and implement callback functions
	 * {@link INfCallbackBluetooth#onDeviceBondStateChanged onDeviceBondStateChanged} and {@link INfCallbackBluetooth#onDeviceUuidsUpdated onDeviceUuidsUpdated}
	 * to be notified if pairing is successful.
	 *
	 * @attention The Android system only supports 7 paired devices maximal. System would delete the first paired device automatically when
	 * the limit is reached. 
	 * @param address valid Bluetooth MAC address.
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 		
	boolean reqBtPair(String address);

	/** 
	 * Request to unpair with given Bluetooth hardware address.
	 * <br>This is an asynchronous call: it will return immediately, and clients should register and implement callback function
	 * {@link INfCallbackBluetooth#onDeviceBondStateChanged onDeviceBondStateChanged}
	 * to be notified if unpairing is successful.
	 * However, this operation only removes pairing record locally. Remote device would not be notified until pairing again.
	 * All connected or connecting profiles should be terminated before unpairing.
	 *
	 * @param address valid Bluetooth MAC address.
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 		
	boolean reqBtUnpair(String address);	
	
	/** 
	 * Request to get the paired device list.
	 * <br>This is an asynchronous call: it will return immediately, and clients should register and implement callback function 
	 * {@link INfCallbackBluetooth#retPairedDevices retPairedDevices}
	 * to be notified of subsequent result.
	 *
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 		
	boolean reqBtPairedDevices();

	/** 
	 * Get the name of local Bluetooth adapter.
	 * <br>If there is an error, the string "UNKNOWN" would be returned.
	 *
	 * @return the String type name of local Bluetooth adapter.
	 */ 		
	String getBtLocalName();
	
	/** 
	 * Request the name of remote Bluetooth device with given address.
	 * <br>This method would return the name announced by remote device in String type only if this remote device
	 * has been scanned before. Otherwise the empty string would be returned.
	 *	 	 
	 * @param address valid Bluetooth MAC address.	 
	 * @return the real String type name of remote device or the empty string.
	 */ 		
	String getBtRemoteDeviceName(String address);

	/** 
	 * Get the address of local Bluetooth adapter.
	 *
	 * @return the String type address of local Bluetooth adapter.
	 */
	String getBtLocalAddress();

	/** 
	 * Set the name of local Bluetooth adapter.
	 *
	 * @param name the name to set.
	 * @return true to indicate the operation is successful, or false erroneous.
	 */ 		
	boolean setBtLocalName(String name);

	/**
	 * Check if Bluetooth is currently enabled.
	 *
	 * @return true if the local adapter is turned on.
	 */
	boolean isBtEnabled();
	
	/** 
	 * Get the current state of local Bluetooth adapter.
	 *
	 * @return int value to denote the current state. Possible values are:
	 *		<p><blockquote><b>ERROR</b>			(int) -1
	 *		<br><b>BT_STATE_OFF</b>				(int) 300
	 *		<br><b>BT_STATE_TURNING_ON</b>		(int) 301
	 *		<br><b>BT_STATE_ON</b>				(int) 302
	 *		<br><b>BT_STATE_TURNING_OFF</b>		(int) 303</blockquote>	
	 */ 		
	int getBtState();

	/** 
	 * Check if Bluetooth is currently scanning remote devices.
	 *
	 * @return true if scanning.
	 */
	boolean isBtDiscovering();

	/** 
	 * Check if Bluetooth is currently discoverable from remote devices.
	 *
	 * @return true if discoverable.
	 */
	boolean isBtDiscoverable();
		
	/** 
	 * Check if auto-connect is currently enabled.
	 *
	 * @return true if auto-connect is enabled.
	 */
	boolean isBtAutoConnectEnable();
	
	/** 
	 * Request to connect HFP, A2DP, and AVRCP to remote device.
	 * <br>This is an asynchronous call: it will return immediately with int returned value, 
	 * which denotes the profiles nFore service plans to connect to, and 
	 * clients should register and implement callback functions
	 * {@link INfCallbackHfp#onHfpStateChanged onHfpStateChanged}, 
	 * {@link INfCallbackA2dp#onA2dpStateChanged onA2dpStateChanged}, and
	 * {@link INfCallbackAvrcp#onAvrcpStateChanged onAvrcpStateChanged}  
	 * to be notified of subsequent profile state changes.
	 * 
	 *
	 * @param address valid Bluetooth MAC address.
	 * @return int value to denote the profiles planned to connect. Possible values are:
	 *		<blockquote><b>ERROR</b>	(int) -1
	 *		<br><b>PROFILE_HFP</b>		(int) 1
	 *		<br><b>PROFILE_A2DP</b>		(int) (1 << 1)
	 *		<br><b>PROFILE_AVRCP</b>	(int) (1 << 2)</blockquote>	 
	 * For example, value 6 (0000 0110) means that HFP and A2DP would be connected.	 	 
	 */ 	
	int reqBtConnectHfpA2dp(String address);

	/** 
	 * Request to disconnect all connected profiles.
	 * <br>This is an asynchronous call: it will return immediately with int returned value, 
	 * which denotes the profiles nFore service plans to disconnect to, and 
	 * clients should register and implement callback functions
	 * {@link INfCallbackHfp#onHfpStateChanged onHfpStateChanged}, 
	 * {@link INfCallbackA2dp#onA2dpStateChanged onA2dpStateChanged}, and
	 * {@link INfCallbackAvrcp#onAvrcpStateChanged onAvrcpStateChanged}  
	 * to be notified of subsequent profile state changes.
	 * 
	 * <br>If there is no connection currently, this request would return ERROR.
	 *
	 * @return int value to denote the profiles planned to disconnect. Possible values are:
	 *		<p><blockquote><b>ERROR</b>			(int) -1
	 *		<br><b>PROFILE_HFP</b>				(int) 1
	 *		<br><b>PROFILE_A2DP</b>				(int) (1 << 1)
	 *		<br><b>PROFILE_AVRCP</b>			(int) (1 << 2)
	 *		<br><b>PROFILE_PBAP</b>				(int) (1 << 5)
	 *		<br><b>PROFILE_MAP</b>				(int) (1 << 6)
	 *		<br><b>PROFILE_SPP</b>				(int) (1 << 7)
	 *		<br><b>PROFILE_HID</b>				(int) (1 << 8)
	 *		<br><b>PROFILE_PANU</b>				(int) (1 << 9)
	 *		<br><b>PROFILE_NAP</b>     			(int) (1 << 10)
	 *		<br><b>PROFILE_DUN</b>     			(int) (1 << 11)
	 *		<br><b>PROFILE_FTP</b>     			(int) (1 << 12)</blockquote>  
	 * For example, value 6 (0000 0110) means that HFP and A2DP would be disconnected.	 	 
	 */
	int reqBtDisconnectAll();
	
	/** 
	 * Get the supported profiles of remote device.
	 * The requested address must be the paired device.
	 *
	 * This command will return with an integer value immediately, which represents the supported profiles.
	 * If 0x00 is returned, that means UUID fetched from system framework is null and nFore service will request
	 * SDP query to this device automatically. Clients should register and implement callback functions
	 * {@link IServiceCallback#onDeviceUuidsUpdated onDeviceUuidsUpdated} 
	 * to be notified of subsequent result.
	 *
	 * @param address valid Bluetooth MAC address of paired device.
	 * @return the supported profiles of paired device in int type. Possible values are:
	 *		<p><blockquote><b>ERROR</b>			(int) -1
	 *		<br><b>PROFILE_HFP</b>				(int) 1
	 *		<br><b>PROFILE_A2DP</b>				(int) (1 << 1)
	 *		<br><b>PROFILE_AVRCP</b>			(int) (1 << 2)
	 * 		<br><b>PROFILE_AVRCP_13</b>			(int) (1 << 3)
	 * 		<br><b>PROFILE_AVRCP_14</b>			(int) (1 << 4)
	 *		<br><b>PROFILE_PBAP</b>				(int) (1 << 5)
	 *		<br><b>PROFILE_MAP</b>				(int) (1 << 6)
	 *		<br><b>PROFILE_SPP</b>				(int) (1 << 7)
	 *		<br><b>PROFILE_HID</b>				(int) (1 << 8)
	 *		<br><b>PROFILE_PANU</b>				(int) (1 << 9)
	 *		<br><b>PROFILE_NAP</b>     			(int) (1 << 10)
	 *		<br><b>PROFILE_DUN</b>     			(int) (1 << 11)
	 *		<br><b>PROFILE_FTP</b>     			(int) (1 << 12)
	 *		<br><b>PROFILE_IAP</b>     			(int) (1 << 13)</blockquote>
	 * For example, value 7 (0000 0110) means it supports HFP and A2DP.
	 */
	int getBtRemoteUuids(String address);

	/**
	 * Check if the remote device ACL disconnected.
	 *
	 * @param address the address of remote bonding device in String type.
	 */
	boolean isDeviceAclDisconnected(String address);

	/**
	 * Switch Bluetooth mode to other role.
	 *
	 * @param mode the mode of Bluetooth role in integer type. Possible values are:
	 * 		<p><blockquote><b>MODE_CAR</b>		(int) 1
	 *		<br><b>MODE_TABLET</b>				(int) 2
	 */
	boolean switchBtRoleMode(int mode);

	/**
	 * Get Bluetooth role mode in integer.
	 *
	 * @return The mode of Bluetooth role in integer type. Possible values are:
	 * 		<p><blockquote><b>MODE_CAR</b>		(int) 1
	 *		<br><b>MODE_TABLET</b>				(int) 2
	 */
	int getBtRoleMode();

	/**
	 * Set nFore auto-connect mechanism condition and period.
	 * 
	 * nFore auto-connect mechanism will start based on the below conditions: 
	 * <b>AUTO_CONNECT_WHEN_BT_ON</b> will start auto-connect after BT turn ON and continue reconnect to the last HFP connected device in a specific period of time.
	 * <b>AUTO_CONNECT_WHEN_PAIRED</b> will start auto-connect when device changes from unbond to bonded. And it stops if there is any device is connected or connecting.
	 * This condition will only try to connect once.
	 * <b>AUTO_CONNECT_WHEN_OOR</b> will start auto-connect when device goes out of range and continue reconnect in a specific period of time.
	 *
	 * nFore auto-connect mechanism will stop based on the below conditions: 
	 * start discover device, request a connect command, BT turn off, device unpaired or set auto-connect setting to <b>AUTO_CONNECT_DISABLE</b>.
	 *
	 * When the device goes out of range or BT ON will reconnect automatically for a period of time.
	 * This time period is set in the seconds scale.
	 * For example, if the value set "600", that means the time period will be set to 10 minutes.
	 * Set to "0" means auto-connect non stop.
	 *
	 * <br>This is an asynchronous call: it will return immediately.
	 * and clients should register and implement callback functions
	 * {@link INfCallbackBluetooth#onBtAutoConnectStateChanged onBtAutoConnectStateChanged}, and this will callback
	 * when auto-connect mechanism try to connect a device or when setting is changed.
	 * 
	 * @param condition The bitmask of automatically connect condition. Possible values are:
	 *		<p><blockquote><b>AUTO_CONNECT_DISABLE</b>	(int) 0
	 *		<br><b>AUTO_CONNECT_WHEN_BT_ON</b>			(int) (1 << 0)
	 *		<br><b>AUTO_CONNECT_WHEN_PAIRED</b>			(int) (1 << 1)
	 * 		<br><b>AUTO_CONNECT_WHEN_OOR</b>			(int) (1 << 2)</blockquote>
	 * For example, value 5 (0000 0101) means auto-connect when BT turn ON and device out of range.
	 *
	 * @param period a period of time for auto-connect when BT ON and device out of range.
	 */
	void setBtAutoConnect(int condition, int period);

	/**
	 * Get nFore auto-connect conditions.
	 *
	 * @return condition The bitmask of automatically connect condition. Possible values are:
	 *		<p><blockquote><b>AUTO_CONNECT_DISABLE</b>	(int) 0
	 *		<br><b>AUTO_CONNECT_WHEN_BT_ON</b>			(int) (1 << 0)
	 *		<br><b>AUTO_CONNECT_WHEN_PAIRED</b>			(int) (1 << 1)
	 * 		<br><b>AUTO_CONNECT_WHEN_OOR</b>			(int) (1 << 2)</blockquote>
	 * For example, value 5 (0000 0101) means auto-connect when BT turn ON and device out of range.
	 */
	int getBtAutoConnectCondition();

	/**
	 * Get nFore auto-connect period setting.
	 *
	 * When the device goes out of range or BT ON will reconnect automatically for a period of time.
	 * This time period is in the seconds scale.
	 * For example, if the value set "600", that mean the time period will be set to 10 minutes.
	 *
	 * @return time a period of time for auto-connect when BT ON and device out of range.
	 */
	int getBtAutoConnectPeriod();

	/**
	 * Get nFore auto-connect state.
	 *
	 * @return state auto-connect state.
	 * <p>The possible values of state are: 
	 * 		<p><blockquote><b>STATE_NOT_INITIALIZED</b>			(int) 100
	 * 		<br><b>STATE_READY</b>								(int) 110
	 * 		<br><b>STATE_AUTO_CONNECT_BTON_CONNECTING</b>		(int) 121
	 *		<br><b>STATE_AUTO_CONNECT_PAIRED_CONNECTING</b>		(int) 122
	 *		<br><b>STATE_AUTO_CONNECT_OOR_CONNECTING</b>		(int) 123</blockquote>
	 */
	int getBtAutoConnectState();

	/**
	 * Get nFore auto-connecting target device address if nFore auto-connect mechanism is connecting to a device.
	 *
	 * @return address auto-connect target address.
	 * If nFore auto-connect mechanism not in connecintg state will return <b>DEFAULT_ADDRESS</b> , which is 00:00:00:00:00:00.
	 */
	String getBtAutoConnectingAddress();

}

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpotp_temp
-- Object: labpotp_temp_get_user_data_bkp(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labpotp_temp_get_user_data_bkp(jsonb, refcursor); Type: FUNCTION; Schema: labpotp_temp; Owner: -
--

CREATE FUNCTION labpotp_temp.labpotp_temp_get_user_data_bkp(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labpotp_temp.labpotp_temp_get_user_data_bkp
(
    '{
    "opt_type": 1,
  "start_date_time": "2019-03-23 00:00:00",
  "end_date_time": "2019-03-23 23:20:02"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
	v_custom_id int[];
	i numeric;
	v_id numeric;
	v_teamGender character varying;
   v_schoolCode character varying;
 v_schoolName  character varying;
 v_contactNumber character varying;
 v_schoolAddress character varying;
 v_schoolRepresentativeName character varying;
 v_schoolRepresentativeEmail character varying;
 v_extraMarksExecutiveId character varying;
 v_extraMarksExecutiveName character varying;
 v_extraMarksExecutiveNumber character varying;
 v_schoolLogoFilePath character varying;
 v_girlsTeamPlayerDetailList jsonb;
 v_boysTeamPlayerDetailList jsonb;
 v_data jsonb;
 v_dob character varying;
 v_email character varying;
 v_height character varying;
 v_weight character varying;
 v_bloodGroup character varying;
 v_parentName character varying;
 v_studentName character varying;
 v_schoolIdPath character varying;
 v_aadharCardPath character varying;
 v_playingHistory character varying;
  v_emergencyContact character varying;
 v_parentContactNumber character varying;
  v_birthCertificatePath character varying;
 v_parentConsentFormPath character varying;
  v_passportSizePhotoPath character varying;
  v_medicalReleaseFormPath character varying;
v_gender character varying;
v_no numeric;
v_parentEmail character varying;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
		delete from labpotp_temp.labpotp_temp_temp_data;
		
		select array_agg(custom_id) 
		into v_custom_id		
		from labpotp_temp.labpotp_temp_custom_web_json
	    where module_name = 'schoolregisteration'
		and datajson->'data'->'is_affiliated_school'::text='true'		
		and created_date between v_start_date_time and v_end_date_time;
		
		raise notice ' v_custom_id %',v_custom_id;
 
 
 		foreach i in array(v_custom_id)
			loop
				select  datajson->'data'->'formData'->>'teamGender',
						datajson->'data'->'user_info'->>'schoolCode',
						datajson->'data'->'user_info'->>'schoolName',
						datajson->'data'->'user_info'->>'contactNumber',
						datajson->'data'->'user_info'->>'schoolAddress',
						datajson->'data'->'user_info'->>'schoolRepresentativeName',
						datajson->'data'->'user_info'->>'schoolRepresentativeEmail',
						datajson->'data'->'user_info'->>'extraMarksExecutiveId',
						datajson->'data'->'user_info'->>'extraMarksExecutiveName',
						datajson->'data'->'user_info'->>'extraMarksExecutiveNumber',
						datajson->'data'->'user_info'->>'schoolLogoFilePath',
						datajson->'data'->'formData'->>'girlsTeamPlayerDetailList',
						datajson->'data'->'formData'->>'boysTeamPlayerDetailList'
					into v_teamGender,
						 v_schoolCode,
						 v_schoolName,
						 v_contactNumber,
						 v_schoolAddress,
						 v_schoolRepresentativeName,
						 v_schoolRepresentativeEmail,
						 v_extraMarksExecutiveId,
						 v_extraMarksExecutiveName,
						 v_extraMarksExecutiveNumber,
						 v_schoolLogoFilePath,
						 v_girlsTeamPlayerDetailList,
						 v_boysTeamPlayerDetailList
				 from labpotp_temp.labpotp_temp_custom_web_json
				 where custom_id = i;
					 
--		 		raise notice ' i %',i;
--		 		raise notice ' v_girlsTeamPlayerDetailList %',v_girlsTeamPlayerDetailList;
				  v_no := 1;

	if v_teamGender = 'Both' then
		
		raise notice 'both';
			for v_data in select * from jsonb_array_elements(v_girlsTeamPlayerDetailList)
				  loop
				  
				  v_gender:='GirlNo ';
					select  v_data->>'dob',
							v_data->>'email',
							v_data->>'height',
							v_data->>'weight',
							v_data->>'bloodGroup',
							v_data->>'parentName',
							v_data->>'parentEmail',
							v_data->>'studentName',
							v_data->'schoolIdPath'->>'filePath',
							v_data->'aadharCardPath'->>'filePath',
							v_data->>'playingHistory',
							v_data->>'emergencyContact',
							v_data->>'parentContactNumber',
							v_data->'birthCertificatePath'->>'filePath',
				   		    v_data->'parentConsentFormPath'->>'filePath',
							v_data->'passportSizePhotoPath'->>'filePath',
							v_data->'medicalReleaseFormPath'->>'filePath'
				   into
						   v_dob,
						   v_email,
						   v_height,
						   v_weight,
						   v_bloodGroup,
						   v_parentName,
						   v_parentEmail,
						   v_studentName,
						   v_schoolIdPath,
						   v_aadharCardPath,
						   v_playingHistory,
						   v_emergencyContact,
						   v_parentContactNumber,
						   v_birthCertificatePath,
						   v_parentConsentFormPath,
						   v_passportSizePhotoPath,
						   v_medicalReleaseFormPath;
--v_teamGender,						   
				insert into labpotp_temp.labpotp_temp_temp_data(schoolcode,team_gender,student_no,playinghistory,schoolname,contact_no,schooladdress,schoolrepresentativename,schoolrepresentativeemail,extramarksexecutiveid,
				extramarksexecutivename,extramarksexecutivenumber,schoollogofilepath,dob,email,height,weight,bloodgroup,parentname,studentname,schoolidpath,aadharcardpath,emergencycontact,parentcontactnumber,
				birthcertificatepath,parentconsentformpath,passportsizephotopath,medicalreleaseformpath)
				values(v_schoolCode,v_teamGender,v_gender||v_no,v_playingHistory,v_schoolName,v_contactNumber,v_schoolAddress,v_schoolRepresentativeName,v_schoolRepresentativeEmail,v_extraMarksExecutiveId,
					v_extraMarksExecutiveName,v_extraMarksExecutiveNumber,v_schoolLogoFilePath,v_dob,v_email,v_height,v_weight,v_bloodGroup,v_parentName,v_studentName,v_schoolIdPath,v_aadharCardPath,v_emergencyContact,
					v_parentContactNumber,v_birthCertificatePath,v_parentConsentFormPath,v_passportSizePhotoPath,v_medicalReleaseFormPath);

				v_no:=v_no + 1;
				
					   raise notice 'v_playingHistory %',v_playingHistory;

				 end loop;

			for v_data in select * from jsonb_array_elements(v_boysTeamPlayerDetailList)
				  loop
   				  v_gender:='BoyNo ';
				  
					select  v_data->>'dob',
							v_data->>'email',
							v_data->>'height',
							v_data->>'weight',
							v_data->>'bloodGroup',
							v_data->>'parentName',
							v_data->>'parentEmail',
							v_data->>'studentName',
							v_data->'schoolIdPath'->>'filePath',
							v_data->'aadharCardPath'->>'filePath',
							v_data->>'playingHistory',
							v_data->>'emergencyContact',
							v_data->>'parentContactNumber',
							v_data->'birthCertificatePath'->>'filePath',
				   		    v_data->'parentConsentFormPath'->>'filePath',
							v_data->'passportSizePhotoPath'->>'filePath',
							v_data->'medicalReleaseFormPath'->>'filePath'
				   into
						   v_dob,
						   v_email,
						   v_height,
						   v_weight,
						   v_bloodGroup,
						   v_parentName,
						   v_parentEmail,
						   v_studentName,
						   v_schoolIdPath,
						   v_aadharCardPath,
						   v_playingHistory,
						   v_emergencyContact,
						   v_parentContactNumber,
						   v_birthCertificatePath,
						   v_parentConsentFormPath,
						   v_passportSizePhotoPath,
						   v_medicalReleaseFormPath;

				 end loop;

					insert into labpotp_temp.labpotp_temp_temp_data(schoolcode,team_gender,student_no,playinghistory,schoolname,contact_no,schooladdress,schoolrepresentativename,schoolrepresentativeemail,extramarksexecutiveid,
				extramarksexecutivename,extramarksexecutivenumber,schoollogofilepath,dob,email,height,weight,bloodgroup,parentname,studentname,schoolidpath,aadharcardpath,emergencycontact,parentcontactnumber,
				birthcertificatepath,parentconsentformpath,passportsizephotopath,medicalreleaseformpath)
				values(v_schoolCode,v_teamGender,v_gender||v_no,v_playingHistory,v_schoolName,v_contactNumber,v_schoolAddress,v_schoolRepresentativeName,v_schoolRepresentativeEmail,v_extraMarksExecutiveId,
					v_extraMarksExecutiveName,v_extraMarksExecutiveNumber,v_schoolLogoFilePath,v_dob,v_email,v_height,v_weight,v_bloodGroup,v_parentName,v_studentName,v_schoolIdPath,v_aadharCardPath,v_emergencyContact,
					v_parentContactNumber,v_birthCertificatePath,v_parentConsentFormPath,v_passportSizePhotoPath,v_medicalReleaseFormPath);

				v_no:=v_no + 1;

	
	else

			if (v_girlsTeamPlayerDetailList != null or v_girlsTeamPlayerDetailList != '[]') then
			
				v_teamGender:='Girls';
			    v_gender:='GirlNo ';

				raise notice 'girls';
				
				for v_data in select * from jsonb_array_elements(v_girlsTeamPlayerDetailList)
				  loop
					select  v_data->>'dob',
							v_data->>'email',
							v_data->>'height',
							v_data->>'weight',
							v_data->>'bloodGroup',
							v_data->>'parentName',
							v_data->>'parentEmail',
							v_data->>'studentName',
							v_data->'schoolIdPath'->>'filePath',
							v_data->'aadharCardPath'->>'filePath',
							v_data->>'playingHistory',
							v_data->>'emergencyContact',
							v_data->>'parentContactNumber',
							v_data->'birthCertificatePath'->>'filePath',
				   		    v_data->'parentConsentFormPath'->>'filePath',
							v_data->'passportSizePhotoPath'->>'filePath',
							v_data->'medicalReleaseFormPath'->>'filePath'
				   into
						   v_dob,
						   v_email,
						   v_height,
						   v_weight,
						   v_bloodGroup,
						   v_parentName,
						   v_parentEmail,
						   v_studentName,
						   v_schoolIdPath,
						   v_aadharCardPath,
						   v_playingHistory,
						   v_emergencyContact,
						   v_parentContactNumber,
						   v_birthCertificatePath,
						   v_parentConsentFormPath,
						   v_passportSizePhotoPath,
						   v_medicalReleaseFormPath;
						   
						   
				insert into labpotp_temp.labpotp_temp_temp_data(schoolcode,team_gender,student_no,playinghistory,schoolname,contact_no,schooladdress,schoolrepresentativename,schoolrepresentativeemail,extramarksexecutiveid,
				extramarksexecutivename,extramarksexecutivenumber,schoollogofilepath,dob,email,height,weight,bloodgroup,parentname,studentname,schoolidpath,aadharcardpath,emergencycontact,parentcontactnumber,
				birthcertificatepath,parentconsentformpath,passportsizephotopath,medicalreleaseformpath)
				values(v_schoolCode,v_teamGender,v_gender||v_no,v_playingHistory,v_schoolName,v_contactNumber,v_schoolAddress,v_schoolRepresentativeName,v_schoolRepresentativeEmail,v_extraMarksExecutiveId,
					v_extraMarksExecutiveName,v_extraMarksExecutiveNumber,v_schoolLogoFilePath,v_dob,v_email,v_height,v_weight,v_bloodGroup,v_parentName,v_studentName,v_schoolIdPath,v_aadharCardPath,v_emergencyContact,
					v_parentContactNumber,v_birthCertificatePath,v_parentConsentFormPath,v_passportSizePhotoPath,v_medicalReleaseFormPath);

				v_no:=v_no + 1;
		   

				 end loop;
	
			end if;
	
		if (v_boysTeamPlayerDetailList != null or v_boysTeamPlayerDetailList != '[]') then
			
				v_teamGender:='Boys';
    			v_gender:='BoyNo ';

				raise notice 'boys';
				
				for v_data in select * from jsonb_array_elements(v_boysTeamPlayerDetailList)
				  loop
					select  v_data->>'dob',
							v_data->>'email',
							v_data->>'height',
							v_data->>'weight',
							v_data->>'bloodGroup',
							v_data->>'parentName',
							v_data->>'parentEmail',
							v_data->>'studentName',
							v_data->'schoolIdPath'->>'filePath',
							v_data->'aadharCardPath'->>'filePath',
							v_data->>'playingHistory',
							v_data->>'emergencyContact',
							v_data->>'parentContactNumber',
							v_data->'birthCertificatePath'->>'filePath',
				   		    v_data->'parentConsentFormPath'->>'filePath',
							v_data->'passportSizePhotoPath'->>'filePath',
							v_data->'medicalReleaseFormPath'->>'filePath'
				   into
						   v_dob,
						   v_email,
						   v_height,
						   v_weight,
						   v_bloodGroup,
						   v_parentName,
						   v_studentName,
						   v_schoolIdPath,
						   v_aadharCardPath,
						   v_playingHistory,
						   v_emergencyContact,
						   v_parentContactNumber,
						   v_birthCertificatePath,
						   v_parentConsentFormPath,
						   v_passportSizePhotoPath,
						   v_medicalReleaseFormPath;

				insert into labpotp_temp.labpotp_temp_temp_data(schoolcode,team_gender,student_no,playinghistory,schoolname,contact_no,schooladdress,schoolrepresentativename,schoolrepresentativeemail,extramarksexecutiveid,
				extramarksexecutivename,extramarksexecutivenumber,schoollogofilepath,dob,email,height,weight,bloodgroup,parentname,studentname,schoolidpath,aadharcardpath,emergencycontact,parentcontactnumber,
				birthcertificatepath,parentconsentformpath,passportsizephotopath,medicalreleaseformpath)
				values(v_schoolCode,v_teamGender,v_gender||v_no,v_playingHistory,v_schoolName,v_contactNumber,v_schoolAddress,v_schoolRepresentativeName,v_schoolRepresentativeEmail,v_extraMarksExecutiveId,
					v_extraMarksExecutiveName,v_extraMarksExecutiveNumber,v_schoolLogoFilePath,v_dob,v_email,v_height,v_weight,v_bloodGroup,v_parentName,v_studentName,v_schoolIdPath,v_aadharCardPath,v_emergencyContact,
					v_parentContactNumber,v_birthCertificatePath,v_parentConsentFormPath,v_passportSizePhotoPath,v_medicalReleaseFormPath);

				v_no:=v_no + 1;


				 end loop;
	
			end if;

		end if;		
			
			end loop;
			
			if  v_opt_type=1 then
			
			open p_user_cursor for
				select * from labpotp_temp.labpotp_temp_temp_data;
			end if;
 
end;

$$;


--

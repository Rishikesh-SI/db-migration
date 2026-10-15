-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_get_trending_assets_r(numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: ttmum_get_trending_assets_r(numeric, numeric, numeric[]); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_get_trending_assets_r(p_hours numeric, p_itemnumber numeric, p_entityarr numeric[], OUT p_trendingassetsjson jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_hours text := ''''||p_hours||'hours''';
	v_xhoursagodate timestamp;
    v_entityrolemapid_string text;
    v_entitycount numeric;
    v_trendingassetsjson json;
    
begin
    
    select date_trunc('day',(current_timestamp at time zone 'utc' - (v_hours)::interval)) into v_xhoursagodate;
    
    select count(1) into v_entitycount from unnest(p_entityarr)entity_id;
    
    v_entityrolemapid_string := '{'||array_to_string(p_entityarr,',')||'}';
    
    select ('{"trending_assets":['||string_agg((row_to_json(row))::text,',')||']}')::json
    from(select av.asset_id, av.asset_type_id, sum(view_count) view_count
         from ttmum.ttmum_assets_view av
         where view_date >= v_xhoursagodate
         and exists(select 1
                    from ttmum.ttmum_asset_entity_map aem1
                    where aem1.asset_id = av.asset_id
                    and aem1.asset_type_id = av.asset_type_id
                    and aem1.entity_role_map_id =any(v_entityrolemapid_string::numeric[])
                    group by aem1.asset_id,aem1.asset_type_id
                    having count(1) = v_entitycount)
         group by asset_id, asset_type_id
         order by view_count desc
         limit p_itemnumber) row
	into v_trendingassetsjson;
    
    select ('{"items":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from(select distinct al.asset_list_id, al.asset_id, al.asset_type_id, al.asset_title, al.title_alias, aa.author_id, al.short_desc, al.tags, 
         		al.primary_entity_role_map_id, al.secondary_entity_role_map_id, al.total_assets, al.image_file_name, al.image_path, al.duration, 
         		al.show_in_web, al.show_in_mobile, al.show_in_app, al.published_version_number, al.is_trashed, al.created_date, al.updated_date, 
         		al.created_by, al.updated_by, al.is_active, al.is_deleted, al.is_published, al.published_date, al.asset_guid, al.show_copyright, 
         		al.order_number, al.image_file_name, al.image_path, u.display_name user_name, pem.entity_name primary_entity_name, 
         		sem.entity_name secondary_entity_name, coalesce(pelm.entity_display_name, pem.entity_display_name) pri_ent_disp_name, 
            	coalesce(selm.entity_display_name, sem.entity_display_name) sec_ent_disp_name, al.short_title, c.view_count
         from ttmum.ttmum_asset_list al
         join (select (json_array_elements(a->'trending_assets')->>'asset_id')::numeric asset_id, 
               			(json_array_elements(a->'trending_assets')->>'asset_type_id')::numeric asset_type_id, 
               			(json_array_elements(a->'trending_assets')->>'view_count')::numeric view_count
               from (select v_trendingassetsjson as a) b) c
         on c.asset_id = al.asset_id
         and c.asset_type_id = al.asset_type_id
         left join ttmum.ttmum_author_action aa
         on aa.asset_id = al.asset_id
         and aa.asset_type_id = al.asset_type_id
         and aa.action_id = 4
         left join ttmum.ttmum_user u
         on u.user_id = aa.author_id
         left join ttmum.ttmum_entity_role_map perm
         on perm.entity_role_map_id = al.primary_entity_role_map_id
         left join ttmum.ttmum_entity_master pem
         on pem.entity_master_id = perm.entity_master_id
         left join ttmum.ttmum_entity_role_map serm
         on serm.entity_role_map_id = al.primary_entity_role_map_id
         left join ttmum.ttmum_entity_master sem
         on sem.entity_master_id = serm.entity_master_id
         left join ttmum.ttmum_asset_entity_map aem
         on aem.asset_id = al.asset_id
         and aem.asset_type_id = al.asset_type_id
         and aem.entity_role_map_id in (select entity_role_map_id 
                                        from ttmum.ttmum_entity_role_map 
                                        where entity_role_id in(select entity_role_id 
                                                                from ttmum.ttmum_entity_category))
         left join ttmum.ttmum_entity_role_map lerm
         on lerm.entity_role_map_id = aem.entity_role_map_id
         left join ttmum.ttmum_entity_master lem
         on lem.entity_master_id = lerm.entity_master_id
         left join ttmum.ttmum_entity_language_map pelm
         on pelm.entity_master_id = pem.entity_master_id
         and pelm.language_master_id = lem.entity_master_id
         left join ttmum.ttmum_entity_language_map selm
         on selm.entity_master_id = sem.entity_master_id
         and selm.language_master_id = lem.entity_master_id
         order by c.view_count desc
        )row
	into p_trendingassetsjson;
    
    /*if (select * from unnest(array[p_entityarr])) = 4570 then
    p_trendingassetsjson := '{
  "items": [
    {
      "published_version_number": 1,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "krunal-pandya-gets-married-to-pankhuri-4516",
      "asset_guid": "1f679992-2a96-4c84-b68f-6dd77cfb51e7",
      "duration": null,
      "updated_by": 14,
      "asset_id": 4516,
      "view_count": 3611,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": null,
      "show_copyright": null,
      "short_desc": null,
      "created_by": 14,
      "asset_list_id": 235344,
      "user_name": "ttmum",
      "updated_date": "2017-12-28T07:40:06.492129",
      "secondary_entity_role_map_id": 4556,
      "image_path": "ba/14/4c/0/",
      "tags": null,
      "published_date": "2017-12-28T07:18:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "zgPJ87P83e.JPG",
      "show_in_web": null,
      "asset_type_id": 2,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "विराट के बाद इस क्रिकेटर ने रचाई शादी, सचिन, अंबानी से लेकर बड़े-बड़े दिग्गज हुए शामिल",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": 21,
      "short_title": null,
      "created_date": "2017-12-28T07:40:06.492129",
      "author_id": 1,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 3,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "mitchell-starc-ball-of-the-21st-century-james-vince-crack-australia-england-ashes",
      "asset_guid": "18f690a3-3084-4abd-be1b-e916598ab0c0",
      "duration": null,
      "updated_by": 1,
      "asset_id": 58182,
      "view_count": 3492,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": 0,
      "show_copyright": null,
      "short_desc": "पर्थ का वाका क्रिकेट स्टेडियम अपने आखिरी क्रिकेट की मेजबानी कर रहा है. मैदान पर पहले तीन दिन तक बल्लेबाजों का जलवा रहा लेकिन चौथे दिन वो हुआ जिसकी उम्मीद किसी को भी नहीं थी. ऑस्ट्रेलिया के तेज गेंदबाज मिचेल स्टार्क ने वो गेंद फेंकी जिसे स्पिन दिग्गज ने बॉल ऑफ द एशेज करार दिया.",
      "created_by": 1,
      "asset_list_id": 229097,
      "user_name": "Shashank Shekhar",
      "updated_date": "2017-12-17T16:20:49.119597",
      "secondary_entity_role_map_id": 4554,
      "image_path": "24/c3/c5/0/",
      "tags": null,
      "published_date": "2017-12-17T16:10:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "MeQl6cnxrF.jpg",
      "show_in_web": null,
      "asset_type_id": 1,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "मिचेल स्टार्क की ''बॉल ऑफ द एशेज'' देख हर कोई हुआ दंग, ''सचिन 1000 बार बोल्ड होते''",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": null,
      "short_title": null,
      "created_date": "2017-12-17T16:11:27.402515",
      "author_id": 13,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 6,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "dhoni-eyes-are-faster-than-the-hawk",
      "asset_guid": "5acb71b9-94dc-492b-8186-f6f875d50654",
      "duration": null,
      "updated_by": 20,
      "asset_id": 58169,
      "view_count": 3157,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": 0,
      "show_copyright": null,
      "short_desc": "श्रीलंका के खिलाफ खेले जा रहे तीसरे वनडे मुकाबले में महेंद्र सिंह धोनी ने एक बार फिर विकेट के पीछे गजब की फुर्ती दिखाई. मैच के 27वें ओवर की पहली गेंद पर धोनी ने उपुल थरंगा का स्टंप आउट कर सबको हैरान कर दिया.",
      "created_by": 20,
      "asset_list_id": 228962,
      "user_name": "ttmum",
      "updated_date": "2017-12-17T11:37:18.080141",
      "secondary_entity_role_map_id": 4554,
      "image_path": "8e/9c/9b/0/",
      "tags": null,
      "published_date": "2017-12-17T11:05:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "4wZdYQajZp.JPG",
      "show_in_web": null,
      "asset_type_id": 1,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "बाज से भी तेज है धोनी की आंखें !",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": null,
      "short_title": null,
      "created_date": "2017-12-17T11:08:15.87008",
      "author_id": 1,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 12,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "rohit-sharma-came-with-wife-ritika-virat-kohli-anushka-sharma-reception-at-mumbai",
      "asset_guid": "466f28e8-4962-4d80-b9a2-1ea0c5b2e950",
      "duration": null,
      "updated_by": 20,
      "asset_id": 4511,
      "view_count": 3004,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": null,
      "show_copyright": null,
      "short_desc": "टीम इंडिया के ''हिटमैन'' रोहित शर्मा ने की विरुष्का के रिसेप्शन में धमाकेदार एंट्री  ",
      "created_by": 20,
      "asset_list_id": 234347,
      "user_name": "ttmum",
      "updated_date": "2017-12-26T17:36:27.871285",
      "secondary_entity_role_map_id": 4556,
      "image_path": "f9/4c/bf/0/",
      "tags": null,
      "published_date": "2017-12-26T15:46:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "eRna2Ulz7d.JPG",
      "show_in_web": null,
      "asset_type_id": 2,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "टीम इंडिया के ''हिटमैन'' रोहित शर्मा ने की विरुष्का के रिसेप्शन में धमाकेदार एंट्री  ",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": 12,
      "short_title": null,
      "created_date": "2017-12-26T15:57:00.384853",
      "author_id": 1,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 2,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "dhoni-arrived-midnight-at-salman-khan-farmhouse-after-virat-anushkas-reception-4512",
      "asset_guid": "edc86408-d1d3-4724-b9b1-07659928942a",
      "duration": null,
      "updated_by": 20,
      "asset_id": 4512,
      "view_count": 2862,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": null,
      "show_copyright": null,
      "short_desc": "विराट-अनुष्का के रिसेप्शन के बाद आधी रात को यहां पहुंचे धोनी",
      "created_by": 20,
      "asset_list_id": 234631,
      "user_name": "ttmum",
      "updated_date": "2017-12-27T06:13:09.738308",
      "secondary_entity_role_map_id": 4556,
      "image_path": "8e/5e/33/0/",
      "tags": null,
      "published_date": "2017-12-27T03:53:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "gmlMxWJJIo.JPG",
      "show_in_web": null,
      "asset_type_id": 2,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "विराट-अनुष्का के रिसेप्शन के बाद आधी रात को यहां पहुंचे धोनी",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": 9,
      "short_title": null,
      "created_date": "2017-12-27T04:09:04.785503",
      "author_id": 1,
      "order_number": null,
      "is_published": 1
    }
  ]
}'::jsonb;
elsif (select * from unnest(array[p_entityarr])) = 4571 then
	 p_trendingassetsjson := '{
  "items": [
    {
      "published_version_number": 5,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "the-line-belongs-to-dhoni",
      "asset_guid": "249b3a0c-cd2c-46c2-a5aa-d9603031ef2f",
      "duration": null,
      "updated_by": 22,
      "asset_id": 58168,
      "view_count": 1909,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": 0,
      "show_copyright": null,
      "short_desc": "Trust MS Dhoni to spoil your party if you put your guard down even for a split second. Sri Lanka opening batsman Upul Tharanga learnt that the hard way during the final ODI between India and Sri Lanka at Visakhapatnam.",
      "created_by": 22,
      "asset_list_id": 228960,
      "user_name": "ttmum",
      "updated_date": "2017-12-17T11:19:30.882501",
      "secondary_entity_role_map_id": 4554,
      "image_path": "a5/2a/05/0/",
      "tags": null,
      "published_date": "2017-12-17T11:05:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "Rs6UstG9fS.JPG",
      "show_in_web": null,
      "asset_type_id": 1,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "The line belongs to Dhoni",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": null,
      "short_title": null,
      "created_date": "2017-12-17T11:06:02.099494",
      "author_id": 1,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 5,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "munros-record-ton-helps-nz-sweep-t20-series",
      "asset_guid": "3c4228a1-14e6-4d0c-94de-1f95de774a6f",
      "duration": null,
      "updated_by": 22,
      "asset_id": 58539,
      "view_count": 1553,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": 0,
      "show_copyright": null,
      "short_desc": "Colin Munro smashed his way into the record books as New Zealand crushed the West Indies by 119 runs in the final Twenty20 here to sweep the series.",
      "created_by": 22,
      "asset_list_id": 238803,
      "user_name": "Agencies",
      "updated_date": "2018-01-03T11:09:10.041625",
      "secondary_entity_role_map_id": 4554,
      "image_path": "20/e0/9c/0/",
      "tags": null,
      "published_date": "2018-01-03T10:57:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "3UCgklPnJc.JPG",
      "show_in_web": null,
      "asset_type_id": 1,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "Munro''s record ton helps NZ sweep T20 series",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": null,
      "short_title": null,
      "created_date": "2018-01-03T11:01:04.762394",
      "author_id": 18,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 3,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "mitchell-starc-bowls-outstanding-ball-to-get-james-vinces-wicket-in-ashes-at-waca-perth-ball-of-ashes",
      "asset_guid": "9e10d611-90b4-488b-9e6d-6f03a9059cd3",
      "duration": null,
      "updated_by": 22,
      "asset_id": 58174,
      "view_count": 1484,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": 0,
      "show_copyright": null,
      "short_desc": "England were in a desperate search of a partnership, having lost three top order batsmen cheaply and still trailing Australia by almost 200 runs when Starc sucked the life out of the visitors batting-line up with what is being hailed as the ‘Ball of Ashes’.",
      "created_by": 22,
      "asset_list_id": 229008,
      "user_name": "ttmum",
      "updated_date": "2017-12-17T12:52:51.515512",
      "secondary_entity_role_map_id": 4554,
      "image_path": "aa/f8/86/0/",
      "tags": null,
      "published_date": "2017-12-17T12:42:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "B1Rc10e9lD.JPG",
      "show_in_web": null,
      "asset_type_id": 1,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "\"The ball of Ashes\"",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": null,
      "short_title": null,
      "created_date": "2017-12-17T12:45:28.713996",
      "author_id": 1,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 4,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "smith-stands-on-englands-way-again",
      "asset_guid": "13f76988-77c6-4315-94a9-56bde6748e08",
      "duration": null,
      "updated_by": 22,
      "asset_id": 58135,
      "view_count": 1446,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": 0,
      "show_copyright": null,
      "short_desc": "At stumps Australia were 203 for three, with Smith on 92 and Shaun Marsh on seven, a deficit of 200 runs with seven wickets in hand after dismissing England for 403.",
      "created_by": 22,
      "asset_list_id": 227889,
      "user_name": "Agencies",
      "updated_date": "2017-12-15T11:57:47.1151",
      "secondary_entity_role_map_id": 4554,
      "image_path": "6a/26/82/0/",
      "tags": null,
      "published_date": "2017-12-15T11:28:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "2Q5JviUtim.JPG",
      "show_in_web": null,
      "asset_type_id": 1,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "Smith stands on England''s way, again",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": null,
      "short_title": null,
      "created_date": "2017-12-15T11:29:41.628705",
      "author_id": 18,
      "order_number": null,
      "is_published": 1
    },
    {
      "published_version_number": 2,
      "primary_entity_name": "Cricket",
      "show_in_mobile": null,
      "title_alias": "sunrisers-all-but-confirm-warner-as-captain-for-ipl-11-4505",
      "asset_guid": "2adad1e0-5f38-4672-845c-beb4c17939fa",
      "duration": null,
      "updated_by": 22,
      "asset_id": 4505,
      "view_count": 1404,
      "sec_ent_disp_name": "Cricket",
      "show_in_app": null,
      "show_copyright": null,
      "short_desc": "Australian opener David Warner is all set to lead Sunrisers Hyderabad for the fourth straight season after taking over the reins from Darren Sammy in 2015.",
      "created_by": 22,
      "asset_list_id": 233638,
      "user_name": "aritra",
      "updated_date": "2017-12-25T12:39:54.921393",
      "secondary_entity_role_map_id": 4556,
      "image_path": "d5/8f/4b/0/",
      "tags": null,
      "published_date": "2017-12-25T12:26:00",
      "is_active": 1,
      "secondary_entity_name": "Cricket",
      "image_file_name": "M17tgBZxSe.jpg",
      "show_in_web": null,
      "asset_type_id": 2,
      "primary_entity_role_map_id": 4572,
      "is_trashed": 0,
      "asset_title": "Sunrisers all but confirm Warner as captain for IPL 11",
      "pri_ent_disp_name": "Cricket",
      "is_deleted": 0,
      "total_assets": 13,
      "short_title": null,
      "created_date": "2017-12-25T12:38:39.019729",
      "author_id": 22,
      "order_number": null,
      "is_published": 1
    }
  ]
}'::jsonb;
end if;*/
    
    if p_trendingassetsjson is not null then
    	p_result := 1;
	else
    	p_result := 0;
	end if;
    
exception
	when others then
    	p_result := -1;
        p_trendingassetsjson := '{"items":[]}'::jsonb;

end;

$$;


--

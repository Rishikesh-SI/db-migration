-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zvn_img_play_publish_pk
-- Type: INDEX

-- Name: zvn_img_play_publish_pk; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX zvn_img_play_publish_pk ON zeven.zeven_pic_play_usr_act_map USING btree (is_published, is_saved, is_deleted);


--

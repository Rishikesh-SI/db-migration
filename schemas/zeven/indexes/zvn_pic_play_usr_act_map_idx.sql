-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zvn_pic_play_usr_act_map_idx
-- Type: INDEX

-- Name: zvn_pic_play_usr_act_map_idx; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX zvn_pic_play_usr_act_map_idx ON zeven.zeven_pic_play_usr_act_map USING btree (image_name);


--

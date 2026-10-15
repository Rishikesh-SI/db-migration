-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_pic_play_usr_act_map_idx
-- Type: INDEX

-- Name: zeven_pic_play_usr_act_map_idx; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX zeven_pic_play_usr_act_map_idx ON zeven.zeven_pic_play_usr_act_map USING btree (play_activity_type_id, play_activity_ref_id, user_id);


--

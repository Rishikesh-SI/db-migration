-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zvn_usr_following_id_idx
-- Type: INDEX

-- Name: zvn_usr_following_id_idx; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX zvn_usr_following_id_idx ON zeven.zeven_user_following USING btree (user_id);


--

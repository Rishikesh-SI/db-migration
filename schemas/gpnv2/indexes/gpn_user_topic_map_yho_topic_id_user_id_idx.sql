-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_topic_map_yho_topic_id_user_id_idx
-- Type: INDEX

-- Name: gpn_user_topic_map_yho_topic_id_user_id_idx; Type: INDEX; Schema: gpnv2; Owner: -
--

CREATE INDEX gpn_user_topic_map_yho_topic_id_user_id_idx ON gpnv2.gpn_user_topic_map_yho USING btree (topic_id, user_id);


--

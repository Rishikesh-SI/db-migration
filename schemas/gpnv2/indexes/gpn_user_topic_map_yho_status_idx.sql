-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_topic_map_yho_status_idx
-- Type: INDEX

-- Name: gpn_user_topic_map_yho_status_idx; Type: INDEX; Schema: gpnv2; Owner: -
--

CREATE INDEX gpn_user_topic_map_yho_status_idx ON gpnv2.gpn_user_topic_map_yho USING btree (status);


--

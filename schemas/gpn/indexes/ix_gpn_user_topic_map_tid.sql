-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_user_topic_map_tid
-- Type: INDEX

-- Name: ix_gpn_user_topic_map_tid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_user_topic_map_tid ON gpn.gpn_user_topic_map USING btree (topic_id);


--

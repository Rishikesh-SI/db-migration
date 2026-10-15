-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_user_topic_change_tid
-- Type: INDEX

-- Name: ix_gpn_user_topic_change_tid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_user_topic_change_tid ON gpn.gpn_user_topic_change USING btree (topic_id);


--

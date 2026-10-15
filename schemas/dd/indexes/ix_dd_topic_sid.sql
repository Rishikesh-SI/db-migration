-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_topic_sid
-- Type: INDEX

-- Name: ix_dd_topic_sid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_topic_sid ON dd.dd_topic USING btree (sport_id);


--

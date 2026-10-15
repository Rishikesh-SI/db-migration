-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_topic_sid
-- Type: INDEX

-- Name: ix_dd_topic_sid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_topic_sid ON dd_30_04_24.dd_topic USING btree (sport_id);


--
